class MeansController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @means = if params[:query].blank?
               Mean.all.order(created_at: :desc).page(params[:page]).per(5)
             else
               Mean.joins(:user)
                   .where("title LIKE ? OR approach LIKE ? OR category LIKE ? OR users.name LIKE ?",
                          "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
                   .order(created_at: :desc).page(params[:page]).per(5)
             end
  end

  def new
    @mean = Mean.new
  end

  def create
    @mean = current_user.means.new(mean_params)
    
    respond_to do |format|
      if @mean.save
        format.html { redirect_to mean_path(@mean), success: 'ストレス解消法を作成しました' }
        format.json { render :show, status: :created, location: @mean }
      else
        format.html { render :new, danger: 'ストレス解消法を作成できませんでした' }
        format.json { render json: @mean.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @mean = Mean.find(params[:id])
    @mean_comment = MeanComment.new
    @mean_comments = @mean.mean_comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @mean = current_user.means.find(params[:id])
  end

  def update
    @mean = current_user.means.find(params[:id])

    respond_to do |format|
      if @mean.update(mean_params)
        format.html { redirect_to mean_path(@mean), success: 'ストレス解消法を更新しました' }
        format.json { render :show, status: :ok, location: @mean }
      else
        format.html { render :edit, danger: 'ストレス解消法を更新できませんでした' }
        format.json { render json: @mean.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mean = current_user.means.find(params[:id])
    @mean.destroy!

    respond_to do |format|
      format.html { redirect_to means_path, success: 'ストレス解消法を削除しました' }
      format.json { head :no_content }
    end
  end

  private

  def mean_params
    params.require(:mean).permit(:title, :situation, :approach, :result, :category)
  end
end
