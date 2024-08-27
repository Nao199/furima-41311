FactoryBot.define do
  factory :formobject do
    postal_code   { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 47) }
    city          { '東京都' }
    address       { '渋谷区1-1-1' }
    building      { '東京ハイツ101' }
    phone_number  { '09012345678' }
    token         { "tok_#{Faker::Alphanumeric.alphanumeric(number: 30)}" }
  end
end
