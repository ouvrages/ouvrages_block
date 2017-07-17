class CreateTitles < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def change
    create_table :titles do |t|
      t.references :parent, polymorphic: true
      t.integer :position
      t.string :title

      t.timestamps
    end
  end
end
