class TimeSlotCreator
  PRIMETIME_PRICE = 6000
  REGULAR_PRICE = 4000

  def run
    create_next_month_of_time_slots
  end

  private

  def most_recent_slot
    @most_recent_slot ||= TimeSlot.most_recent
  end

  def create_time_slot
    if !TimeSlot.exists?
      TimeSlot.create(started_at: 1.month.ago, price: price_for(1.month.ago))
    end
  end

  def start_month
    @start_month ||= begin
      most_recent_month = most_recent_slot.started_at.mon
      month_number = (most_recent_month + 1)
      month_number % 12
    end
  end

  def year
    @year ||= begin
      most_recent_year = most_recent_slot.started_at.year
      if start_month == 12
        most_recent_year + 1
      else
        most_recent_year
      end
    end
  end

  def create_next_month_of_time_slots
    create_time_slot
    days_of_month = (1..Time.days_in_month(start_month, year)).to_a
    days_of_month.each do |day|
      save_time_slots(day)
    end
  end

  def save_time_slots(day)
    [9, 12, 15, 18, 21].each do |hour|
      start_date = Time.zone.local(year, start_month, day, hour)
      price = price_for(start_date)
      TimeSlot.create(started_at: start_date, price: price)
    end
  end

  def price_for(start_date)
    hour = start_date.hour
    if hour > 15 || start_date.saturday? || start_date.sunday?
      PRIMETIME_PRICE
    else
      REGULAR_PRICE
    end
  end
end
