class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  before_action :set_day, only: [:create, :new]

  def index
    @notices = Notice.all
  end

  def show
  end

  def new
    @notice = @day.notices.build
  end

  def edit
  end

  def create
    @notice = @day.notices.build(notice_params)

    if @notice.save
      redirect_to days_path, notice: 'Notice was successfully created.'
    else
      render :new
    end
  end

  def update
    if @notice.update(notice_params)
      redirect_to days_path, notice: 'Notice was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @notice.destroy
    redirect_to days_path, notice: 'Notice was successfully destroyed.'
  end

  private

  def set_notice
    @notice = Notice.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:title, :content, :day_id)
  end

  def set_day
    @day = Day.find(params[:day_id])
  end
end
