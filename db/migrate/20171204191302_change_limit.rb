class ChangeLimit < ActiveRecord::Migration[5.1]
  def change
		change_column :stocks, :turnover_value, :integer, limit: 8
		change_column :stocks, :turnover_price, :integer, limit: 8
  end
end
