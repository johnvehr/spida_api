class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.integer :plan_title

      t.timestamps
    end
  end
end
