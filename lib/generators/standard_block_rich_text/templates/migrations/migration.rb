class CreateRichTexts < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]
  def up
    create_table :rich_texts do |t|
      t.references :parent, polymorphic: true
      t.integer :position
      t.text :text

      t.timestamps
    end
  end
end
