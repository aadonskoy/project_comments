FactoryBot.define do
  factory :comment do
    association :project
    username { "User" }
    text { "Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
  end
end
