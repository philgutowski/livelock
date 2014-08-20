desc "Create booking time slots one month at a time.  Automatically creates a new month after the last month in the table"
task make_time_slots: :environment do 
  TimeSlotCreator.new.run
end

desc "Check if the today is the first day of the month.  If it is, create booking time slots one month at a time.  Automatically creates a new month after the last month in the table"
task make_time_slots_monthly: :environment do 
  TimeSlotCreator.new.run_monthly
end
