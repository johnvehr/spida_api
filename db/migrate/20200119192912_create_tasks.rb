class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :task_title
      t.string :task_desc
      t.references :project, null: false, foreign_key: true
      t.integer :status
      t.integer :priority

      t.timestamps
    end
  end
end
