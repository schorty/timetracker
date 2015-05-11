FactoryGirl.define do
  factory :day do
    beginning_of_day Time.now
    hours_worked { Faker::Number.between(650, 950).to_i / 100.0 }
    day_of_week { Faker::Number.between(0, 6).to_i }
    business 0
  end
end
