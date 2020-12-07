class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.references :container, null: false, foreign_key: true
    end
  end
end
