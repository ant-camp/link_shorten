require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  config.fixture_path               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }

  config.include FactoryBot::Syntax::Methods

  config.before :all do
    FactoryBot.reload
  end

  Capybara.register_driver :chrome do |app|
   Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

 Capybara.register_driver :headless_chrome do |app|
   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
     chromeOptions: { args: %w(headless disable-gpu window-size=1024,768) }
   )

   Capybara::Selenium::Driver.new app,
                                  browser: :chrome,
                                  desired_capabilities: capabilities
 end

end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
