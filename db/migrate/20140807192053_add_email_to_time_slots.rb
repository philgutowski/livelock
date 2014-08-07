class AddEmailToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :email, :string, null: true
  end
end
