FactoryGirl.define do
  factory :score do
    created_at {DateTime.now.beginning_of_day}
    factory :pickup do
      score -1
    end

    factory :dropoff do
      score 1
    end

    factory :neutral do
      score 0
    end
  end
end
