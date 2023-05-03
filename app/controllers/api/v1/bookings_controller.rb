class Api::V1::BookingsController < ApplicationController

  def index 
    @bookings = Booking.where(restaurant_id: params[:restaurant_id])
    render json: @bookings
  end

  def all 
    @bookings = Booking.all
    render json: @bookings
  end

  def show
    @booking = Booking.find(params[:id])
    render json: @booking
  end

  def create
    if !booking_valid_day
      render json: { error: 'Unable to create Booking, todas las mesas reservadas por dia 20'}, status: 400
    elsif !booking_valid_restaurants
      render json: { error: 'Unable to create Booking, todas las mesas reservadas por restaruante 15'}, status: 400
    else
      @booking = Booking.new(booking_params)
      @booking.restaurant_id = params[:restaurant_id]
      if @booking.save
        render json: @booking
      else
        render json: { error: 'Unable to create Booking'}, status: 400
      end
    end  
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking
      @booking.update(booking_params)
      render json: { message: 'Booking successfully updated'}, status: 200
    else
      render json: { error: 'Unable to update Booking'}, status: 400
    end
  end

  def delete
    @booking = Booking.find(params[:id])
    if @booking
      @booking.destroy
      render json: { message: 'Booking successfully deleted'}, status: 200
    else
      render json: { error: 'Unable to delete Booking'}, status: 400
    end
  end

  private 

  def booking_params
    params.require(:booking).permit(:date, :description, :restaurant_id)
  end

  def booking_valid_day
    valid = true
    bookings_count = Booking.where(date: params[:date]).count
    puts bookings_count
    if bookings_count >= Booking::DAY_TABLES
      valid = false
    end
    return valid
  end

  def booking_valid_restaurants
    valid = true
    bookings_count = Booking.where(restaurant_id: params[:restaurant_id], date: params[:date]).count
    puts bookings_count
    if bookings_count >= Booking::RES_TABLES
      valid = false
    end
    return valid
  end

end
