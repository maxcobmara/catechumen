FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :student do
    id_no1     "740515145043"
    name        "Yaacob Noor"
    email       "maxcobmara@gmail.com"
    telephone   "0123838150"
    status_type true
    sponsor_id  1
    gender      1
    marital_status   1
    intake_id   1
  end
end