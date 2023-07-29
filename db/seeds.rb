10.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: '12345678',
    password_confirmation: '12345678' 
  )
end

30.times do |index|
  Mean.create!(
    user: User.offset(rand(User.count)).first,
    title: "タイトル#{index}",
    situation: "イライラしていた時の状況#{index}",
    approach: "ストレス解消法#{index}",
    result: "ストレス解消法を実践した結果#{index}"
  )
end