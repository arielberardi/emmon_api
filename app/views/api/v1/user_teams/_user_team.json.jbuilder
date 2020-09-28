json.extract! user_team, :id, :employee_id, :team_id, :created_at, :updated_at
json.url api_v1_user_team_url(user_team, format: :json)
