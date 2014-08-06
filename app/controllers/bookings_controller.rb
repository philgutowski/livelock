class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    time_slot = TimeSlot.where(started_at: week)
    @days = time_slot.available.group_by(&:day_of_week)
  end

  def create
    booking = Booking.new(booking_params)

    if booking.save
      invite_lockitron_user
    end
    redirect_to root_path
  end

  private

  def booking_params
    params.require(:booking).permit(
      :fullname,
      :email,
      :phone,
      :special_requirements,
      time_slot_ids: [],
    )
  end

  def lockitron_params
    params.require(:booking).permit(
      :phone,
      :email,
      :fullname,
    )
  end

  def week
    today = Date.today
    beginning_of_week = today.at_beginning_of_week
    end_of_week = today.at_end_of_week
    (beginning_of_week .. end_of_week)
  end

  def invite_lockitron_user
    user = Lockitron::User.new(ENV['TOKEN'])
    lock = user.locks.first

    lock.as(user) do |l|
      l.invite(lockitron_params.symbolize_keys)
    end
  end
end
