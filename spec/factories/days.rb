FactoryGirl.define do
  factory :day do
    beginning_of_day Time.now
    hours_worked { Faker::Number.between(650, 950).to_i / 100.0 }
    business :work_day
  end
end
