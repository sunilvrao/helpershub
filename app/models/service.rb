class Service
  include Mongoid::Document
  include Mongoid::Timestamps
  field :provider, :type => String
  field :uid, :type => String
  field :uname, :type => String
  field :confirmed_email, :type => String
  field :unconfirmed_email, :type=>String
  field :confirmation_key, :type=>String
  field :confirmed_at, :type=>DateTime
  embedded_in :user
end
