class CreateUserHistoricals < ActiveRecord::Migration[6.0]
  def change
    create_table :user_historicals do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
