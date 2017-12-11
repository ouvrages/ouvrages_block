require "sass-rails"
require "jquery-rails"
require "bootstrap-sass"
require "sortable/rails"
require "tinymce-rails"
require "tinymce-rails-langs"
require "jquery-fileupload-rails"

module OuvragesBlock
  class Engine < Rails::Engine
    ActiveSupport.on_load(:active_record) do
      require 'ouvrages_block/block'
      include OuvragesBlock::Block
    end
  end
end

require "bootstrap_form/form_builder"
require "ouvrages_block/block_field"

module BootstrapForm
  class FormBuilder
    include BlockField
  end
end
