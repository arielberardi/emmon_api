json.extract! task, :id, :name, :description, :priority, :start_date, :end_date, :current_hours, :project_id, :user_id, :created_at, :updated_at
json.url api_v1_task_url(task, format: :json)
