class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.date :date
      t.float :opening_price
      t.float :high_price
      t.float :low_price
      t.float :closing_price
      t.integer :turnover_value
      t.integer :turnover_price

      t.timestamps
    end
  end
end
