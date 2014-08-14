class AddPriceToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :price, :integer
  end
end
