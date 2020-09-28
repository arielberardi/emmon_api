json.extract! user_historical, :id, :start_date, :end_date, :description, :user_id, :created_at, :updated_at
json.url api_v1_user_historical_url(user_historical, format: :json)
