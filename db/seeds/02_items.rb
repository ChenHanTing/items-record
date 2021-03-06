progressbar = ProgressBar.create(title: 'Creating Items', total: ITEMS_TO_CREATE)

(1..10).each do |i|
  User.find_by_email('k445566778899k@gmail.com').items.create(
    name: "測試商品#{i}",
    quantity: rand(10),
    price: (rand(150) * 10),
    remark: "測試備註#{i}",
    vendor: "測試供應商#{i}",
    )

  progressbar.increment
end