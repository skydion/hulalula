json.array!(@tabs) do |tab|
  json.extract! tab, :id, :name, :states
  json.url tab_url(tab, format: :json)
end
