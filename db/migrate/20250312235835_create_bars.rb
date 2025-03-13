class CreateBars < ActiveRecord::Migration[7.2]
  def change
    create_table :bars do |t|
      t.string :z

      t.timestamps
    end
  end
end
