class Admin
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :registerable, 
  # :token_authenticatable, 
  # :encryptable, 
  # :confirmable, 
  # :lockable, 
  # :timeoutable and 
  # :omniauthable
  devise :database_authenticatable, 
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

end
