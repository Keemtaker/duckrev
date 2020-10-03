class FootballReviewsController < ApplicationController

  def new
    @footie_score = FootballScore.find(params[:football_score_id])
    @review = FootballReview.new
  end

  def create
    new
    @review.football_score = @footie_score
    @review.user = current_user
    @review.content = params[:football_review][:content]
    @review.save
  end

end
