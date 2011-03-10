Factory.define :user do |user|
  user.sequence :username do |n|
    "username#{n}"
  end
  user.sequence :email do |n|
    "username#{n}@emailprovider.com"
  end
  user.password "password"
  user.password_confirmation { |u| u.password }
end