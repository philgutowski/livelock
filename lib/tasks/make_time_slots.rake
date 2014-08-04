# Handle the change of year from Dec to Jan
# Sort TimeSlot so when grabbing .last we are getting the most recent date/time
# Make a default to use DateTime.now if there are not any previous TimeSlots in the table

task make_time_slots: :environment do 
  if TimeSlot.exists?
    last_time_slot = TimeSlot.last
    last_month = last_time_slot.started_at.mon
    year = last_time_slot.started_at.year
    month = (last_month.to_i + 1) % 12
    days_of_month = (1 .. Time.days_in_month(month)).to_a
    days_of_month.each do |day|
      [9, 12, 15, 18, 21].each do |hour|
        time_slot = TimeSlot.new
        time_slot.started_at = DateTime.new(year, month, day, hour)
        time_slot.save
      end
    end
  else
    puts "Please initialize by manually creating a single time slot in the previous month"
  end
  puts TimeSlot.all
end
