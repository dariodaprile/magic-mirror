require 'rspec'
require_relative '../lib/models/user'

describe User do
  it "should be possible to set a password and retrive a hashed version of the password" do
    @user = User.new
    set_password = "password"
    @user.password =set_password
    @user.save!
    @user.reload
    expect (@user.password).to eq set_password
  end
end