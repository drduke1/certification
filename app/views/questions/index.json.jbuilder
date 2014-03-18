json.array!(@questions) do |question|
  json.extract! question, :content, :type, :category, :product_id, :active
  json.url question_url(question, format: :json)
end