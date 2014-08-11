FactoryGirl.define do
  factory :blog do
    title "entry"
    content "This is an entry"
    user
  end
end
