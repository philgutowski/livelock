class TimeSlot < ActiveRecord::Base
  DURATION = 3.hours

  paginates_per 35

  def self.most_recent
    order(:started_at).last
  end

  def self.booked
    where.not(booking_id: nil)
  end

  def self.available
    where(booking_id: nil)
  end

  def self.today
    where("DATE(started_at) = ?", Date.today)
  end

  def date
    started_at.strftime("%a, %b %e")
  end

  def label
    "#{started_at.strftime("%l%P")} to #{ended_at.strftime("%l%P")}"
  end

  def ended_at
    started_at + DURATION
  end

  def booked?
    booking_id
  end
end
