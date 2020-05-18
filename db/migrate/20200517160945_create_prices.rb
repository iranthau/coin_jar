class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.money :price
      t.money :last
      t.money :bid
      t.money :ask
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
