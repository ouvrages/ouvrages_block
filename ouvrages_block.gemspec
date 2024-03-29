# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ouvrages_block/version'

Gem::Specification.new do |spec|
  spec.name          = "ouvrages_block"
  spec.version       = OuvragesBlock::VERSION
  spec.authors       = ["Ouvrages"]
  spec.email         = ["contact@ouvrages-web.fr"]

  spec.summary       = "Ouvrages Block"
  spec.description   = "Ouvrages Block"
  spec.homepage      = "http://ouvrages-web.fr"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "activerecord", ">= 5", "< 6"
  spec.add_runtime_dependency "bootstrap_form", '>= 2.5.2'
  spec.add_runtime_dependency "scrollto-rails"
  spec.add_runtime_dependency "sortable-rails"
  spec.add_runtime_dependency "tinymce-rails"
  spec.add_runtime_dependency "jquery-fileupload-rails"
end
