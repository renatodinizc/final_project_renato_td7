class FreelancersController < ApplicationController
  def show
    @freelancer = current_freelancer
  end

  def edit
    @freelancer = current_freelancer
  end

  def update
    @freelancer = current_freelancer
    @freelancer.update(params.require(:freelancer).permit(:full_name, :social_name,
                        :birth_date, :degree, :description, :experience))
    if @freelancer.valid?(:profile_completion)
      redirect_to freelancer_path(@freelancer)
    else
      render :edit
    end
  end
  
end