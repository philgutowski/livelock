desc "Update lockitron user access for the current day"
task update_user_access: :environment do
  TimeSlot.pluck(:email).each do |email|
    UpdateLockitronTimeSlots.new(email).run
  end
end
