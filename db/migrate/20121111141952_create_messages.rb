class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :messages, :user_id
  end
end
