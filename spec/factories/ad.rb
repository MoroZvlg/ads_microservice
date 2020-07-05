FactoryBot.define do
  factory :ad do
    title { 'test_title' }
    description { 'test_description' }
    city { 'SomeCity' }
    user_id { generate(:id) }
  end
end