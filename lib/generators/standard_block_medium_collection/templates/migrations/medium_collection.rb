class CreateMediumCollections < ActiveRecord::Migration
  def up
    create_table :medium_collections do |t|
      t.references :parent, polymorphic: true
      t.integer :position
      t.timestamps
    end
  end

  def down
    drop_table :medium_collections
  end
end
