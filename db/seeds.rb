10.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: '12345678',
    password_confirmation: '12345678' 
  )
end

CATEGORIES = ["グルメ", "スポーツ", "読書・漫画", "旅行・お出かけ", "映画・動画", "ゲーム", "音楽", "その他・屋内", "その他・屋外"]

40.times do |index|
  Mean.create!(
    user: User.offset(rand(User.count)).first,
    title: "タイトル#{index}",
    situation: "イライラしていた時の状況#{index}",
    approach: "ストレス解消法#{index}",
    result: "ストレス解消法を実践した結果#{index}",
    category: CATEGORIES.sample
  )
end
