class TimeSlot < ActiveRecord::Base
  def self.most_recent
    order(:started_at).last
  end
end
