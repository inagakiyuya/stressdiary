class SearchMeansController < ApplicationController
  def suggestions
    @means = suggestions_for_means
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
            turbo_stream.update('suggestions',
                                partial: 'search_means/suggestions',
                                locals: { means: @means })
      end
    end
  end

  private

  def suggestions_for_means
    if params[:query].blank?
      Mean.all.order(created_at: :desc).page(params[:page]).per(5)
    else
      Mean.search(params[:query], fields: [:title, :approach, :category],
                           operator: 'or', match: :text_middle).page(params[:page])
    end
  end
end
