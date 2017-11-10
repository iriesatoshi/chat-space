FactoryGirl.define do

  factory :message do
    body                  { Faker::Job.title }
    image                 Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.jpg'))
    group
    user
  end

end
