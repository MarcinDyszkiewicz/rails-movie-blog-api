require 'faker'

Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password }


end