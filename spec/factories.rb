FactoryGirl.define do
	factory :user do	
		name	"zharui"
		email	"zrdt713@gmail.com"
		password 	"foobar"
		password_confirmation	"foobar"
	end

#	factory :user do
#		sequence(:name)				{ |n| "Person #{n}" }
#		sequence(:email)			{ |n| "person_#{n}@example" }
#		password							"foobar"
#		password_confirmation	"foobar"
#	end
end
