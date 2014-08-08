# Find upcoming block of continuously-reserved time slots
# if started_at + DURATION = next.started_at, then make continuous
# Update lockitron user expirations to those start, end times

class UpdateLockitronTimeSlots
  def initialize(email)
    @email = email
    @booked_time_slots = TimeSlot.where(email: email).booked.today
  end

  def run
    if @booked_time_slots.count > 0
      @start = @booked_time_slots.first.started_at
      @end = @booked_time_slots.last.ended_at

      update_lockitron_user
    end
  end

  def update_lockitron_user
    user = Lockitron::User.new(ENV.fetch('TOKEN'))
    lock = user.locks.first

    lock.as(user) do |user|
      user.update(start: @start, expiration: @end, email: @email)
    end
  end
end
