class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.datetime :started_at, null: false
      t.belongs_to :booking, index: true
    end
    add_index :time_slots, :started_at
  end
end
