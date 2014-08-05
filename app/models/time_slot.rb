class TimeSlot < ActiveRecord::Base
  DURATION = 3.hours

  def self.most_recent
    order(:started_at).last
  end

  def self.available
    where(booking_id: nil)
  end

  def day_of_week
    started_at.strftime("%A")
  end

  def slot_date
    started_at.to_date
  end

  def label
    "#{started_at.hour} to #{ended_at.hour}"
  end

  def ended_at
    started_at + DURATION
  end
end
