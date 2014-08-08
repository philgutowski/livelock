# Find upcoming block of continuously-reserved time slots
# if started_at + DURATION = next.started_at, then make continuous
# Update lockitron user expirations to those start, end times
class UpdateLockitronTimeSlots
  def run
    find_booked_time_slots
    # check_for_continuity
    # update_lockitron_users
  end

  def find_booked_time_slots
    time_slots = TimeSlot.in_the_future
    puts time_slots
  end
end
