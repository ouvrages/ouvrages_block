require 'rails/generators/active_record/migration'

class StandardBlockTitleGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  class_option :locales, :type => :array, :default => %w( en fr ), :desc => "Locales to generate"

  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end

  def create_migration_file
    template "migrations/migration.rb", "db/migrate/#{StandardBlockTitleGenerator.next_migration_number(standard_block_name_singular)}_create_#{standard_block_name_plural}.rb"
  end

  def create_model_file
    template "models/title.rb.erb", File.join("app", "models", standard_block_name_singular + ".rb")
  end

  def create_locale_files
    locales.each do |locale|
      @locale = locale
      template "locales/#{locale}.yml", "config/locales/#{standard_block_name_singular}.#{locale}.yml"
    end
  end

  def create_view_files
    template "views/admin.html.haml", File.join("app", "views", "admin", standard_block_name_plural, "_block_form.html.haml")
    template "views/show.html.haml", File.join("app", "views", standard_block_name_plural, "_#{standard_block_name_singular}.html.haml")
  end

  private

  def locales
    options[:locales]
  end

  def standard_block_name_singular
    "title"
  end

  def standard_block_name_plural
    "titles"
  end
end
