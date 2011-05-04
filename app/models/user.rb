class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :full_name, :type => String
  field :bio, :type => String
  field :email, :type => String
  embeds_many :services
end
