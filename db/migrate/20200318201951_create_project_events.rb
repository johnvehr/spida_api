class CreateProjectEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :project_events do |t|
      t.references :project, null: false, foreign_key: true
      t.string :project_event_title
      t.datetime :project_event_date

      t.timestamps
    end
  end
end
