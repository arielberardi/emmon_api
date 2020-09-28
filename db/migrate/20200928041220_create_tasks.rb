class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, index: true
      t.text :description, default: ''
      t.string :priority, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.float :current_hours, default: 0
      t.references :project, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
