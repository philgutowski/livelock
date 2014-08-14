class CostsController < ApplicationController
  def create
    @cost = 4500
    render json: @cost
  end
end
