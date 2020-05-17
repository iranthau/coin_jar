class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.money :price
      t.money :last
      t.money :bid
      t.money :ask

      t.timestamps
    end
  end
end
