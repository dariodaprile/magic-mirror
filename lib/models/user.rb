require 'data_mapper'
require 'bcrypt'

class User
  include BCrypt
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String, required: true
  property :email, String, required: true
  property :password_hash, Text, required: true
  property :number_of_log, Integer, :default  => 0


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
