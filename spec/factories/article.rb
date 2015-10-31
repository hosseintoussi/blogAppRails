FactoryGirl.define do
  factory :article do
  	title 				"test title"
  	body				'this is a test body.'
  	published_at		Date.today
  end
end