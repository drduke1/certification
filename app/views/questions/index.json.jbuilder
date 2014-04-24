json.array!(@questions) do |question|
  json.extract! question, :content, :user_id, :type, :category, :product_id, :active
  json.url question_url(question, format: :json)
end