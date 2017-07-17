class CreateImages < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def up
    create_table :images do |t|
      t.references :parent, polymorphic: true
      t.integer :position
      t.string :image_uid
      t.string :image_name
      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
