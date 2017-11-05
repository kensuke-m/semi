json.extract! announcement, :id, :contents, :displayflag, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
