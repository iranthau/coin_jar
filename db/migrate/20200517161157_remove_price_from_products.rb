class RemovePriceFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :price, :money
    remove_column :products, :last, :money
    remove_column :products, :bid, :money
    remove_column :products, :ask, :money
  end
end
