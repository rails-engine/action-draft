# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "action-draft/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = "action-draft"
  spec.version = ActionDraft::VERSION
  spec.authors = ["Jason Lee"]
  spec.email = ["huacnlee@gmail.com"]
  spec.homepage = "http://github.com/rails-engine/action-draft"
  spec.summary = "Action Draft brings your ActiveRecord model to storage multiple draft attributes without add columns to the business table."
  spec.description = "Action Draft brings your ActiveRecord model to storage multiple draft attributes without add columns to the business table."
  spec.license = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "CHANGELOG.md", "README.md"]

  spec.add_dependency "rails", ">= 5.2"

  spec.add_development_dependency "pg"
end
