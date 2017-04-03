require 'active_record'
require "bootstrap_form/form_builder"

require "ouvrages_block/version"
require "ouvrages_block/block_field"

require "scrollto-rails"

module OuvragesBlock

  module Rails
    class Engine < ::Rails::Engine
    end
  end

  extend ActiveSupport::Concern
  class_methods do
    def has_blocks(block_names)

      block_names.each do |block_name|
        has_many block_name, dependent: :destroy, as: :parent, inverse_of: :parent
        accepts_nested_attributes_for block_name, allow_destroy: true
      end

      define_method "block_permitted_attributes" do
        block_names.map do |block_name|
          { "#{block_name}_attributes" => send(block_name).permitted_attributes }
        end
      end

      define_method "blocks" do
        block_names.map do |block_name|
          send(block_name)
        end.flatten.sort_by { |block| block.position || 0 }
      end

      define_method "block_names" do
        block_names
      end
    end
  end
end

ActiveRecord::Base.send(:include, OuvragesBlock)

module BootstrapFormBlockField
  include BlockField
end

module BootstrapForm
  class FormBuilder
    include BootstrapFormBlockField
  end
end
