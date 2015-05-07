class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :destroy]

  def index
    @days = Day.all

    # @statistics_admin = StaticsAdministrator.new()
    # @statistics_calculator = StatisticsCalculator.new(:all)
    # @statistics = @statistics_calculator.perform
  end

  def show
  end

  def new
    @day = Day.new(beginning_of_day: params[:beginning_of_day])
  end

  def edit
  end

  def create
    @day = Day.new(day_params)

    if @day.save
      redirect_to @day, notice: 'Day was successfully created.'
    else
      render :new
    end
  end

  def update
    if @day.update(day_params)
      redirect_to @day, notice: 'Day was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @day.destroy
    redirect_to days_url, notice: 'Day was successfully destroyed.'
  end

  private
    def set_day
      @day = Day.find(params[:id])
    end

    def day_params
      params.require(:day).permit(:beginning_of_day, :hours_worked, :business)
    end
end
