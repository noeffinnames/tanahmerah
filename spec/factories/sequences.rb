FactoryGirl.define do

  sequence :name do |n|
    "name_#{n}"
  end

  sequence :user do |n|
    "user#{n}"
  end

  sequence :uid do |n|
    "deadbeef#{n}"
  end


  basetime = Time.now

  sequence :time do |n|
    basetime - n
  end

end
