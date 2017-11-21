json.extract! request, :id, :subject_id, :staff_id, :studentusername, :studentname, :reason, :permission, :created_at, :updated_at
json.url request_url(request, format: :json)
