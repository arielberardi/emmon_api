class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.string :section, null: false, index: true
      t.boolean :can_create, default: false
      t.boolean :can_read, default: false
      t.boolean :can_update, default: false
      t.boolean :can_delete, default: false
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
