FactoryBot.define do
  factory :task do
    title { "MyString" }
    completed { false }
    user
  end
end
