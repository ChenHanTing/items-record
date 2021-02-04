json.extract! item, :id, :name, :quantity, :price, :remark, :user_id, :vendor, :features, :created_at, :updated_at
json.url admin_item_url(item, format: :json)
