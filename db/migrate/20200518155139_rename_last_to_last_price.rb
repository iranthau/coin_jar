class RenameLastToLastPrice < ActiveRecord::Migration[6.0]
  def change
    rename_column :prices, :last, :last_price
  end
end
