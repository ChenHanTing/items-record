# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_by_email('k445566778899k@gmail.com')

if user.nil?
  user = User.create! email: 'k445566778899k@gmail.com', password: '19940505'
end

items_total = Item.count

(1..10).each do |i|
  user.items.create(
    name: "測試商品#{items_total + i}",
    quantity: rand(10),
    price: (rand(150) * 10),
    remark: "測試備註#{items_total + i}",
    vendor: "測試供應商#{items_total + i}",
  )
end