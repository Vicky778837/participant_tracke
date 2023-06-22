class CoordinatorsController < ApplicationController
  def new
    @coordinator = Coordinator.new
  end

  def create
    @coordinator = Coordinator.new(coordinator_params)
    if @coordinator.save
      redirect_to @coordinator, notice: "Coordinator was successfully created."
    else
      render :new
    end
  end

  private

  def coordinator_params
    params.require(:coordinator).permit(:name, :email, :phone_number, registry_ids: [])
  end
end
