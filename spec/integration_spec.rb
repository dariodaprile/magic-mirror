ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'database_cleaner'

require_relative '../lib/controllers/controller'
# configure rspec to clean the database after each test using database_cleaner
RSpec.configure do |config|

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Capybara.app = Controller

describe 'signing up a user', :type => :feature do
  it 'creates a new user when valid details are provided' do
    expect(User.count).to be == 0
    visit '/'
    within('.signupform') do
      fill_in 'First Name', :with => 'alpha'
      fill_in 'Email', :with => 'alpha@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button 'Sign Up'
    end
    expect(User.count).to be == 1
    page.should have_content('alpha')
  end
end
