class ReviewsController < ApplicationController
  before_filter :authorize
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product_id = params.require(:product_id)
    @review.user_id = session[:user_id]
    if @review.save
      redirect_to [:products]
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to [:products], notice: 'Review deleted!'
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end

end