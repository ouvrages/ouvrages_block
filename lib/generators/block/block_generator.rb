require 'rails/generators/active_record/migration'

class BlockGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
  class_option :locales, :type => :array, :default => %w( en fr ), :desc => "Locales to generate"
  class_option :migration, :type => :boolean, :default => true

  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end

  def create_migration_file
    if migration?
      template "migrations/migration.rb", "db/migrate/#{BlockGenerator.next_migration_number(standard_block_name_singular)}_create_#{standard_block_name_plural}.rb"
    end
  end

  def create_model_file
    template "models/model.rb.erb", File.join("app", "models", standard_block_name_singular + ".rb")
  end

  def create_locale_files
    locales.each do |locale|
      @locale = locale
      template "locales/#{locale}.yml", "config/locales/#{standard_block_name_singular}.#{locale}.yml"
    end
  end

  def create_view_files
    template "views/admin.html.slim", File.join("app", "views", "admin", standard_block_name_plural, "_block_form.html.slim")
    template "views/show.html.slim", File.join("app", "views", standard_block_name_plural, "_#{standard_block_name_singular}.html.slim")
  end

  private

  def migration?
    options[:migration]
  end

  def locales
    options[:locales]
  end

  def standard_block_name_singular
    name.underscore
  end

  def standard_block_name_plural
    standard_block_name_singular.pluralize
  end

  def migration_class_name
    if Rails::VERSION::MAJOR >= 5
      "ActiveRecord::Migration[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    else
      'ActiveRecord::Migration'
    end
  end
end
