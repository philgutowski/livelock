class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @time_slots = TimeSlot.future.page(params[:page])
    @time_slots_by_day = @time_slots.group_by(&:date)
  end

  def create
    booking = Booking.new(booking_params)
    email = booking_params[:email]

    @time_slots = TimeSlot.where(id: booking_params[:time_slot_ids])
    @time_slots.update_all(email: email)

    charger = Charger.new(@time_slots, email, params[:token])

    begin
      charger.create
    rescue Stripe::CardError => error
      flash[:error] = error.message
    end

    if booking.save
      invite_lockitron_user
      ConfirmationMailer.confirmation_email(email).deliver
    end
    redirect_to booking
  end

  def show
    time_slots = TimeSlot.all.where(booking_id: params[:id])
    @time_slots = "#{time_slots.date} from #{time_slots.label}"
  end

  private

  def booking_params
    params.require(:booking).permit(
      :fullname,
      :email,
      :phone,
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
    today = Time.zone.today
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
