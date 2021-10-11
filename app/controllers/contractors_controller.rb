class ContractorsController < ApplicationController

  def show
    @projects = Project.where(contractor: current_contractor)
    @contractor = current_contractor
  end

end