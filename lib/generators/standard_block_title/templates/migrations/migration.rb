class CreateTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :titles do |t|
      t.references :parent, polymorphic: true
      t.integer :position
      t.string :title

      t.timestamps
    end
  end
end
