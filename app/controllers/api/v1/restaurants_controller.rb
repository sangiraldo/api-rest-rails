class Api::V1::RestaurantsController < ApplicationController
  # GET Restaurants
  def index 
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    render json: @restaurant
  end

  def city
    @restaurant = Restaurant.where(city: params[:city])
    render json: @restaurant
  end

  def search_restaurant
    @restaurant = Restaurant.where("lower(name) LIKE ?", params[:search].downcase + "%")
    puts params[:search]
    render json: @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant
    else
      render json: { error: 'Unable to create Restaurant'}, status: 400
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant
      @restaurant.update(restaurant_params)
      render json: { message: 'Restaurant successfully updated'}, status: 200
    else
      render json: { error: 'Unable to update Restaurant'}, status: 400
    end
  end

  def delete
    @restaurant = Restaurant.find(params[:id])
    if @restaurant
      @restaurant.destroy
      render json: { message: 'Restaurant successfully deleted'}, status: 200
    else
      render json: { error: 'Unable to delete Restaurant'}, status: 400
    end
  end

  private 

  def restaurant_params
    params.permit(:name, :description, :address, :city, :photo_url)
  end
end
