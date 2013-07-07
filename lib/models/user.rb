require 'data_mapper'
require 'bcrypt'


class User
  include BCrypt
  include DataMapper::Resource


  property :id, Serial
  property :first_name, String, :required => true
  property :email, String, :required => true, :unique => true, :format => :email_address
  property :password_hash, Text, :required => true
  property :number_of_log, Integer, :default  => 0

  attr_reader :password
  validates_length_of :password, :min => 3, :max =>20

  def password
    @hashed_password ||= Password.new(password_hash)
  end

  def password=(unhashed_password)
    @hashed_password = Password.create(unhashed_password)
    self.password_hash = @hashed_password
  end

end
