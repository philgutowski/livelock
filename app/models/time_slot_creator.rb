class TimeSlotCreator
  def run
    initialize_a_time_slot
    most_recent_slot = TimeSlot.most_recent
    start_month = find_start_month(most_recent_slot)
    year = find_year(most_recent_slot)
    create_month_of_time_slots(start_month, year)
  end

  def initialize_a_time_slot
    if !TimeSlot.exists?
      new_time_slot = TimeSlot.new
      new_time_slot.started_at = 1.month.ago
      new_time_slot.save
    end
  end

  def find_start_month(most_recent_slot)
    most_recent_month = most_recent_slot.started_at.mon
    month_number = (most_recent_month.to_i + 1)
    month_number % 12
  end

  def find_year(most_recent_slot)
    most_recent_year = most_recent_slot.started_at.year
    if find_start_month(most_recent_slot) == 12
      most_recent_year + 1
    else
      most_recent_year
    end
  end

  def create_month_of_time_slots(start_month, year)
    Time.days_in_month(start_month)
    days_of_month = (1..Time.days_in_month(start_month)).to_a
    days_of_month.each do |day|
      save_time_slots(day, start_month, year)
    end
  end

  def save_time_slots(day, start_month, year)
    [9, 12, 15, 18, 21].each do |hour|
      time_slot = TimeSlot.new
      time_slot.started_at = DateTime.new(year, start_month, day, hour)
      time_slot.save
    end
  end
end
