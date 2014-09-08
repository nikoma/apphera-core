FactoryGirl.define do
  factory :user do
    username "foo"
    password "foobar"
    email { "#{username}@apphera.com" }
  end
end