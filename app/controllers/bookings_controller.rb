class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @days = TimeSlot.available #.group_by(&:weekday)
  end
end
