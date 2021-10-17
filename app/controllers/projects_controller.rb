class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
    @proposal = Proposal.new
    @proposals = Proposal.where(project: Project.find(params[:id]))
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:title, :description, :desired_skills,
                          :top_hourly_wage, :proposal_deadline, :remote, :freelancer_expertise_id))
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
                    :top_hourly_wage, :proposal_deadline, :remote, :freelancer_expertise_id))
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

    @projects = Project.where("title LIKE ?", "%#{get_search_input}%").
                or(Project.where("description LIKE ?", "%#{get_search_input}%"))
  end
end