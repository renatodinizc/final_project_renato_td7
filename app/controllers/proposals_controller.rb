class ProposalsController < ApplicationController
  before_action :authenticate_contractor!, :check_proposal_contractor, only: %i[accept deny]
  before_action :authenticate_freelancer!, only: %i[create archive forfeit]
  before_action :authenticate_any!, :identify_current_account, :proposal_accepted?,
                only: %i[show team]

  def show
    # @proposal = Proposal.find(params[:id])
  end

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:proposal_description,
                                                              :hourly_wage, :weekly_hours,
                                                              :expected_conclusion))
    set_proposal_data
    if @proposal.save
      ProposalMailer.with(proposal: @proposal).notify_new_proposal.deliver_now
      redirect_to project_path @proposal.project
    end
  end

  def archive
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO A ESTA PROPOSTA'
      return redirect_to project_path @proposal.project
    end
    # project = @proposal.project
    @proposal.archived = true
    @proposal.save
    redirect_to project_path(@proposal.project)
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

  def forfeit
    @proposal = Proposal.find(params[:id])
    if (3.days.ago..Date.today).cover?(@proposal.updated_at.to_date)
      @proposal.proposal_forfeit!
      redirect_to new_proposal_feedback_path(@proposal)
    else
      failure_forfeit
    end
  end

  private

  def check_proposal_contractor
    @proposal = Proposal.find(params[:id])
    return unless @proposal.contractor != current_contractor

    flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO A PROPOSTAS DESTE PROJETO'
    redirect_to project_path @proposal.project
  end

  def identify_current_account
    @proposal = Proposal.find(params[:id])
    if current_contractor
      return unless @proposal.contractor != current_contractor

      invalid_chat_message
    elsif current_freelancer
      return unless @proposal.freelancer != current_freelancer

      invalid_chat_message
    end
  end

  def proposal_accepted?
    @proposal = Proposal.find(params[:id])
    return unless @proposal.status != 'proposal_approved'

    flash[:notice] = 'CHAT AINDA NÃO ESTÁ LIBERADO PARA ESTA PROPOSTA'
    redirect_to project_path @proposal.project
  end

  def set_proposal_data
    @proposal.project = Project.find(params[:project_id])
    @proposal.freelancer = current_freelancer
    @proposal.contractor = Project.find(params[:project_id]).contractor
  end

  def invalid_chat_message
    flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO AO CHAT DESTA PROPOSTA'
    redirect_to project_path @proposal.project
  end

  def failure_forfeit
    flash[:notice] = 'Você não pode desistir de uma proposta que foi aprovada a mais de três dias!'
    redirect_to project_path @proposal.project
  end
end
