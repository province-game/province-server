Fabricator(:user) do
  email { Faker::Internet.free_email }
  name { Faker::Name.name }
end