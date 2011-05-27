class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :full_name, :type => String
  field :bio, :type => String
  field :email, :type => String
  field :activated, :type=>Boolean, :default=>false
  field :activated_at, :type=>DateTime
  field :profile_set, :type=>Boolean, :default=>false
  references_many :startups, :inverse_of=>:owner
  embeds_many :services
  references_many :requests, :inverse_of=>:owner
  has_one :profile
  has_many :follows
  accepts_nested_attributes_for :profile
  mount_uploader :avatar, AvatarUploader

  def activate!
    self.activated=true
    self.activated_at=DateTime.now
    self.save!
  end

  def follow(followable)
    self.follows.create(:followable=>followable)
  end
  def followables(type=nil)
    self.follows.where(:followable_type=>type).collect(&:followable) if type
    self.follows.collect(&:followable) unless type
  end

end
