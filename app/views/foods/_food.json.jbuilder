json.extract! food, :id, :name, :address, :price, :description, :favorite, :tag, :review, :created_at, :updated_at
json.url food_url(food, format: :json)
