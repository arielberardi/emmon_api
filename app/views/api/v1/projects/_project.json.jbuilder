json.extract! project, :id, :name, :description, :start_date, :end_date, :project_manager_id, :client_id, :created_at, :updated_at
json.url api_v1_project_url(project, format: :json)
