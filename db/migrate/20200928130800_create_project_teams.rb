class CreateProjectTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :project_teams do |t|
      t.references :project, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
