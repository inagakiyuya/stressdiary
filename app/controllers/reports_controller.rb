class ReportsController < ApplicationController
  #before_action :set_reported, only: %i[new create]

  def new
    @report = Report.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_user.id
    @report.reported_id = @user.id
    if @report.save
      redirect_to mypage_path(@user), success: 'ユーザーを通報しました'
    else
      render :new
    end
  end

  private

  #def set_reported
  #  @user = User.find(params[:user_id])
  #end

  def report_params
    params.require(:report).permit(:reason)
  end
end
