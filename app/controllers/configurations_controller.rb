class ConfigurationsController < ApplicationController
  before_action :set_configuration
  before_action :authenticate_user!

  def index
  end

  def edit
  end

  def update
    if @configuration.update(configuration_params)
      redirect_to configurations_url, notice: 'Day was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_configuration
    @configuration = current_user.configuration
  end

  def configuration_params
    params.require(:configuration).permit(:daily_worktime, :overtime_bonus)
  end
end
