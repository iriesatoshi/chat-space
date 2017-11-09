FactoryGirl.define do

  factory :message do
    body                  "aiueo"
    image                 Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.jpg'))
    group
    user
  end

end
