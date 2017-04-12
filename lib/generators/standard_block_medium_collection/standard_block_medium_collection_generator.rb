require 'rails/generators/active_record/migration'

class StandardBlockMediumCollection < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  class_option :locales, :type => :array, :default => %w( en fr ), :desc => "Locales to generate"
  class_option :migration, :type => :boolean, :default => true

  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end

  def create_migration_file
    if migration?
      migration_template "migrations/medium_collection.rb", "db/migrate/create_medium_collections.rb"
      migration_template "migrations/medium.rb", "db/migrate/create_mediums.rb"
    end
  end

  def create_model_file
    template "models/medium_collection.rb.erb", File.join("app", "models", "medium_collection.rb")
    template "models/medium.rb.erb", File.join("app", "models", "medium.rb")
  end

  def create_controller_file
    template "controllers/mediums_controller.rb", File.join("app/controllers/admin/mediums_controller.rb")
  end

  def create_helper_file
    template "helpers/medium_collection_helper.rb", File.join("app/helpers/medium_collection_helper.rb")
  end

  def create_locale_files
    #locales.each do |locale|
    #  @locale = locale
    #  template "locales/#{locale}.yml", "config/locales/#{standard_block_name_singular}.#{locale}.yml"
    #end
  end

  def create_view_files
    template "views/admin.html.haml", File.join("app", "views", "admin", standard_block_name_plural, "_block_form.html.haml")
    template "views/show.html.haml", File.join("app", "views", standard_block_name_plural, "_#{standard_block_name_singular}.html.haml")
    template "views/_medium.html.haml", File.join("app", "views", standard_block_name_plural, "_medium.html.haml")
  end

  def create_javascript_files
    template "javascripts/medium_collection.js", File.join("app", "assets", "javascripts", "medium_collection.js")
    append_to_file("app/assets/javascripts/admin.js", "//= require medium_collection\n", after: "//= require jquery_ujs\n")
  end

  def create_stylesheet_files
    template "stylesheets/medium_collection.css.sass", File.join("app", "assets", "stylesheets", "medium_collection.css.sass")
    append_to_file("app/assets/stylesheets/admin.sass", "@import 'medium_collection'\n", after: "@import 'bootstrap'\n")
  end

  def add_routes
    append_to_file("config/routes/admin.rb", "post 'medium/create' => 'mediums#create', as: :create_medium\n")
  end

  private

  def migration?
    options[:migration]
  end

  def locales
    options[:locales]
  end

  def standard_block_name_singular
    "medium_collection"
  end

  def standard_block_name_plural
    "medium_collections"
  end
end
