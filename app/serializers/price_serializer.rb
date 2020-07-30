class PriceSerializer < ActiveModel::Serializer
  attributes  :id,
              :price,
              :last_price,
              :bid,
              :ask,
              :product_id
end
