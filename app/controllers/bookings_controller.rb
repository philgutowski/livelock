class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    time_slot = TimeSlot.where(started_at: week)
    @days = time_slot.available.group_by(&:day_of_week)
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

  def week
    today = Date.today
    beginning_of_week = today.at_beginning_of_week
    end_of_week = today.at_end_of_week
    (beginning_of_week .. end_of_week)
  end
end
