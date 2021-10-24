class ProposalsController < ApplicationController
  before_action :authenticate_contractor!, :check_proposal_contractor, only: [:accept, :deny]
  before_action :authenticate_freelancer!, only: [:create, :destroy]
  before_action :authenticate_any!, :identify_current_account, :is_proposal_accepted, only: [:show]

  def show
    #@proposal = Proposal.find(params[:id])
  end

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:proposal_description,
                            :hourly_wage, :weekly_hours, :expected_conclusion))
    @proposal.project = Project.find(params[:project_id])
    @proposal.freelancer = current_freelancer
    @proposal.contractor = Project.find(params[:project_id]).contractor
    if @proposal.save
      redirect_to project_path @proposal.project
    else
      @project = @proposal.project
      @proposals = Proposal.where(project: @project)
      
      render 'projects/show'
    end

  end

  def destroy
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO A ESTA PROPOSTA'
      return redirect_to project_path @proposal.project
    end
    
    project = @proposal.project
    @proposal.destroy
    redirect_to project_path(project)
  end

  def accept
    @proposal.proposal_approved!
    @proposal.save
    redirect_to project_path @proposal.project
  end

  def deny
    @proposal.proposal_denied!
    redirect_to new_proposal_feedback_path(@proposal) 
  end

  private

  def check_proposal_contractor
    @proposal = Proposal.find(params[:id])
    if @proposal.contractor != current_contractor
      flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO A PROPOSTAS DESTE PROJETO'
      redirect_to project_path @proposal.project
    end
  end

  def identify_current_account
    @proposal = Proposal.find(params[:id])
    if current_contractor
      if @proposal.contractor != current_contractor
        flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO AO CHAT DESTA PROPOSTA'
        return redirect_to project_path @proposal.project
      end
    elsif current_freelancer
      if @proposal.freelancer != current_freelancer
        flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO AO CHAT DESTA PROPOSTA'
        return redirect_to project_path @proposal.project
      end
    end
  end

  def is_proposal_accepted
    @proposal = Proposal.find(params[:id])
    if @proposal.status != 'proposal_approved'
      flash[:notice] = 'CHAT AINDA NÃO ESTÁ LIBERADO PARA ESTA PROPOSTA'
      return redirect_to project_path @proposal.project
    end
  end

end