class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.references :project_manager, index: true, null: false, foreign_key: { to_table: :users }
      t.references :client, index: true, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
