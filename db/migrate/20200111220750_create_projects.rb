class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :project_title
      t.string :project_desc
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
