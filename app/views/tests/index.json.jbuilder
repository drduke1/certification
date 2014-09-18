json.array!(@tests) do |test|
  json.extract! test, :name, :type, :category, :description, :user_id
  json.url test_url(test, format: :json)
end