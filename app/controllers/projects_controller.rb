class ProjectsController < ApplicationController
  before_action :authenticate_contractor!,
                only: %i[new create edit update close finish destroy]
  before_action :authenticate_any!, only: [:search]
  before_action :check_project_contractor, only: %i[edit update close finish destroy]

  def show
    @project = Project.find(params[:id])
    @proposal = Proposal.new
    @proposals = Proposal.where(project: Project.find(params[:id]), archived: false)
    @chat = Chat.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:title, :description, :desired_skills,
                                                           :top_hourly_wage, :proposal_deadline,
                                                           :remote, :freelancer_expertise_id))
    @project.contractor = current_contractor
    if @project.save
      redirect_to(project_path(@project))
    else
      render :new, alert: 'não conseguiu salvar'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(params.require(:project).permit(:title, :description, :desired_skills,
                                                       :top_hourly_wage, :proposal_deadline,
                                                       :remote, :freelancer_expertise_id))
      redirect_to project_path @project
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to root_path
  end

  def search
    # Vulnerable to SQL injection
    # Investigar melhor o having caso dê tempo
    # https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-having

    @projects = (Project.where('title LIKE ?',
                               "%#{search_strip}%").and(Project.where(status: 'opened')))
                .or((Project.where('description LIKE ?',
                                   "%#{search_strip}%")).and(Project.where(status: 'opened')))
  end

  def close
    @project.closed!
    @proposals = Proposal.where(project: @project)
    @proposals.each do |proposal|
      proposal.proposal_denied!
      Feedback.create(proposal: proposal,
                      body: 'Contratante fechou projeto para recebimento de novas propostas')
    end
    redirect_to project_path(@project)
  end

  def finish
    @project.finished!
    redirect_to project_path(@project)
  end

  private

  def check_project_contractor
    @project = Project.find(params[:id])
    return unless @project.contractor != current_contractor

    flash[:notice] = 'VOCÊ NÃO POSSUI ACESSO A ESTE PROJETO'
    redirect_to project_path @project
  end
end
