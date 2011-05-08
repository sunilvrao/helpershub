class Startup
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :url, :type=>String
  field :address, :type=>String
  field :country, :type=>String
  field :description, :type => String
  referenced_in :owner, :class_name=>'User'
  mount_uploader :logo, LogoUploader
  validates_presence_of :name, :url
end
