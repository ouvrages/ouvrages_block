class CreateMediums < ActiveRecord::Migration
  def up
    create_table :mediums do |t|
      t.references :collection
      t.string :file_uid
      t.string :file_name
      t.string :description
      t.integer :position
      t.timestamps
    end
    add_index :mediums, :collection_id
    add_index :mediums, :position
  end

  def down
    drop_table :mediums
  end
end
