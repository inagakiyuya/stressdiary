class SearchDiariesController < ApplicationController
  def suggestions
    @diaries = suggestions_for_diaries
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
            turbo_stream.update('suggestions',
                                partial: 'search_diaries/suggestions',
                                locals: { diaries: @diaries })
      end
    end
  end
  
  private
  
  def suggestions_for_diaries
    if params[:query].blank?
      Diary.all.order(created_at: :desc).page(params[:page]).per(5)
    else
      Diary.search(params[:query], fields: [:title], operator: 'or', match: :text_middle)
    end
  end
end
