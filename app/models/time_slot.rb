class TimeSlot < ActiveRecord::Base
  DURATION = 3.hours
  DAYS_IN_WEEK = 7
  NUMBER_OF_SLOTS_PER_DAY = 5
  HOURS_TO_BEGINNING_OF_SUNDAY = 20.hours

  paginates_per DAYS_IN_WEEK * NUMBER_OF_SLOTS_PER_DAY

  def self.most_recent
    order(:started_at).last
  end

  def self.booked
    where.not(booking_id: nil)
  end

  def self.available
    where(booking_id: nil)
  end

  def self.future
    order("started_at ASC").
      where("started_at > ?", Time.zone.today.beginning_of_week - HOURS_TO_BEGINNING_OF_SUNDAY)
  end

  def booked?
    booking_id
  end

  def past?
    started_at < Time.zone.now
  end

  def unavailable?
    booked? || past?
  end

  def self.today
    where("DATE(started_at) = ?", Time.zone.today)
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
end
