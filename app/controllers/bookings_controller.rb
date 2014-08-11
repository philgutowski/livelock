class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @time_slots = TimeSlot.order_and_return.page(params[:page])
    @days = @time_slots.group_by(&:date)
  end

  def create
    booking = Booking.new(booking_params)

    time_slots = TimeSlot.where(id: booking_params[:time_slot_ids])
    time_slots.update_all(email: booking_params[:email])

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
      :email,
      :fullname,
    )
  end

  def week
    today = DateTime.zone.today
    beginning_of_week = today.at_beginning_of_week
    end_of_week = today.at_end_of_week
    (beginning_of_week .. end_of_week)
  end

  def invite_lockitron_user
    user = Lockitron::User.new(ENV.fetch('TOKEN'))
    lock = user.locks.first

    lock.as(user) do |l|
      l.invite(lockitron_params.symbolize_keys)
    end

    update_lockitron_time_slots
  end

  def update_lockitron_time_slots
    TimeSlot.pluck(:email).each do |email|
      UpdateLockitronTimeSlots.new(email).run
    end
  end
end
