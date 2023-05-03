class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.datetime :date
      t.string :description

      t.timestamps
    end
  end
end
