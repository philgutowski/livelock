class TimeSlot < ActiveRecord::Base
  DURATION = 3.hours

  def self.most_recent
    order(:started_at).last
  end

  def self.available
    where(booking_id: nil)
  end

  # def self.in_the_future
  #   started_at > DateTime.now
  # end
  #
  # def self.booked
  #   ...
  # end

  def day_of_week
    started_at.strftime("%A")
  end

  def label
    "#{started_at.hour} to #{ended_at.hour}"
  end

  def ended_at
    started_at + DURATION
  end
end
