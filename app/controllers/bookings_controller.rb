class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @days = TimeSlot.all  #.available.group_by(&:weekday)
  end
end
