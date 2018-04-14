json.array!(@gists) do |gist|
  json.extract! gist, :id, :file_name, :text
  json.url gist_url(gist, format: :json)
end
