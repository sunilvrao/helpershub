class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :full_name, :type => String
  field :bio, :type => String
  field :email, :type => String
  field :activated, :type=>Boolean, :default=>false
  field :banned, :type=>Boolean, :default=>false
  field :activated_at, :type=>DateTime
  field :banned_at, :type=>DateTime
  field :profile_set, :type=>Boolean, :default=>false
  references_many :startups, :inverse_of=>:owner
  embeds_many :services
  references_many :requests, :inverse_of=>:owner
  has_one :profile
  has_many :follows
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :profile
  mount_uploader :avatar, AvatarUploader

  def activate!
    self.activated=true
    self.activated_at=DateTime.now
    self.save!
  end

  def ban!
    self.banned=true
    self.banned_at=DateTime.now
    self.save!
  end

  def follow(followable)
    self.follows.create!(:followable=>followable)
  end
  def unfollow(followable)
    self.is_following?(followable).destroy if self.is_following?(followable)
  end
  def followables(type=nil)
    self.follows.where(:followable_type=>type).collect(&:followable) if type
    self.follows.collect(&:followable) unless type
  end
  def is_following?(followable)
    self.follows.where(:followable_id=>followable.id,:followable_type=>followable.class.to_s).first
  end

end
