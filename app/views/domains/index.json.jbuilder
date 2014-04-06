json.array!(@domains) do |domain|
  json.extract! domain, :id, :name, :tld, :expiry
  json.url domain_url(domain, format: :json)
end
