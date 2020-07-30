FactoryBot.define do
  factory :user do
    username { SecureRandom.alphanumeric(7) }
    password { SecureRandom.hex(10) }
  end
end