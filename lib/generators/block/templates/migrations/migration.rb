class Create<%= standard_block_name_plural.capitalize %> < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def up
    create_table :<%= standard_block_name_plural %> do |t|
      t.references :parent, polymorphic: true
      t.integer :position
<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
      t.timestamps
    end
  end

  def down
    drop_table :<%= standard_block_name_plural %>
  end
end
