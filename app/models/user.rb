class User < ActiveRecord::Base
  has_many :messages

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
  								:remember_me,:avatar_url, :name
  
  def write_message(content)
    self.messages.create(content: content)
  end
end
