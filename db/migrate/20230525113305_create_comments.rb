class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text, limit: 255
      t.references :project, null: false, foreign_key: true
      t.string :username, limit: 100

      t.timestamps
    end
  end
end
