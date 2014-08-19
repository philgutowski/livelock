class RemoveSpecialRequirementsFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :special_requirements
  end
end
