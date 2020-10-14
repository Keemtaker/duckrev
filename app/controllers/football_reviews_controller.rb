class FootballReviewsController < ApplicationController

  def new
    @score = FootballScore.find(params[:football_score_id])
    @review = @score.football_reviews.new
  end

  def create
    new
    @review = FootballReview.new(football_review_params)
    @review.football_score_id = @score.id
    @review.user_id = current_user.id

    if @review.save
      flash[:notice] = "Thanks for your #{current_user.football_reviews.count.ordinalize} game review"
      redirect_to football_scores_path
    else
      render :new
    end
  end

  def football_review_params
    params.require(:football_review).permit(:rating, :content, :football_score_id, :user_id)
  end

end
