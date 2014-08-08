class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :lockitron_id, null: false

      t.timestamps
    end
  end
end
