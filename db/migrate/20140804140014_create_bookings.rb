class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :first_name, index: true, null: false
      t.string :last_name, index: true, null: false
      t.string :email, index: true, null: false
      t.string :phone, null: false
      t.text :special_requirements, default: ""

      t.timestamps null: false
    end
  end
end
