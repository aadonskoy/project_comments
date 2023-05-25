class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, limit: 100
      t.string :description, limit: 255
      t.boolean :completed

      t.timestamps
    end
  end
end
