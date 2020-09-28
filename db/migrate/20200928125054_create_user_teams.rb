class CreateUserTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :user_teams do |t|
      t.references :employee, index: true, null: false, foreign_key: { to_table: :users }
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
