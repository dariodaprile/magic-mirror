ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'database_cleaner'

require_relative '../lib/controllers/controller'
# require_relative './spec_helper'

# configure rspec to clean the database after each test using database_cleaner
RSpec.configure do |config|

  # config.include SpecHelper

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
    # expect(User.count).to be == 1
    page.should have_content('Thanks for registering')
  end

  it "should grow the count each time the user logs in" do
    visit '/'
    within('.signupform') do
      fill_in 'First Name', :with => 'alpha'
      fill_in 'Email', :with => 'alpha@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button 'Sign Up'
    end
    fill_in 'Email', :with => 'alpha@gmail.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log In'
    page.should have_content('You are! I told you 1 times')
    click_link 'Sign Out'
    visit '/'
    within('.loginform') do
      fill_in 'Email', :with => 'alpha@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button 'Log In'
    end
    page.should have_content('You are! I told you 2 times')
  end
end
