require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/channels/'
  add_filter '/jobs/'
  add_filter '/mailers/'
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers

  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  config.before(type: :system) do
    driven_by :rack_test
  end

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
