class ReviewsController < ApplicationController
  def new
    @footie_score = FootballScore.find(params[:football_score_id])
    @review = Review.new
  end

  def create
    new
    @review.football_score = @footie_score
    @review.user = current_user
    @review.save

  end
end
