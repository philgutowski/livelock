class AddPriceToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :price, :integer, null: false
  end
end
