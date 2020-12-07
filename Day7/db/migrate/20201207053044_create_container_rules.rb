class CreateContainerRules < ActiveRecord::Migration[6.0]
  def change
    create_table :container_rules do |t|
      t.references :container, null: false, foreign_key: true
      t.references :rule, null: false, foreign_key: true
      t.integer :count, null: false, defualt: 1
    end
  end
end
