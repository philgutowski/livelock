class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @days = TimeSlot.all  #.available.group_by(&:weekday)
  end

  def create
    Booking.create(booking_params)
    redirect_to root_path
  end

  private

  def booking_params
    params.require(:booking).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :special_requirements,
      time_slot_ids: [],
    )
  end
end
