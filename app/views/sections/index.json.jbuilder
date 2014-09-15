json.array!(@sections) do |section|
  json.extract! section, :name, :active
  json.url section_url(section, format: :json)
end