class RemoveLastNameFromBookings < ActiveRecord::Migration
  def change
    rename_column :bookings, :first_name, :fullname
    remove_column :bookings, :last_name
  end
end
