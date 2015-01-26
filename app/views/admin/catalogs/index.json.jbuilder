json.array!(@admin_catalogs) do |admin_catalog|
  json.extract! admin_catalog, :id, :name
  json.url admin_catalog_url(admin_catalog, format: :json)
end
