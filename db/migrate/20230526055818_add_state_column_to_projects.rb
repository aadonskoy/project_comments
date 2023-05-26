class AddStateColumnToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :state, :string, limit: 100, null: false, default: "not_started"
    add_index :projects, :state
  end
end
