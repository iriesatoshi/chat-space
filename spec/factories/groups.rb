FactoryGirl.define do

  factory :group do
    group_name { Faker::Name.title }
  end

end
