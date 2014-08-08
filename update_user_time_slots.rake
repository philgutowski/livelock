# Find upcoming block of continuously reserved time
# if started_at + DURATION = next.started_at, then make continuous
# Update user expiration to those start and end times

desc "Update lockitron start and expiration times for users booked slots"
task update_lockitron_time_slots: :environment do
  UpdateLockitronTimeSlots.new.run
end
