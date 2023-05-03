class DropFactsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :facts
  end
end
