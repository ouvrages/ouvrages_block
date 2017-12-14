class Create<%= standard_block_migration_name %> < <%= migration_class_name %>
  def up
    create_table :rich_texts do |t|
      t.references :parent, polymorphic: true
      t.integer :position
      t.text :text

      t.timestamps
    end
  end

  def down
    drop_table :<%= standard_block_name_plural %>
  end
end
