class Invitation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, :type => String
  field :from, :type => String
  field :status, :type => String
  field :unique_id, :type => String
  field :accepted, :type => Boolean
  field :deleted, :type => Boolean, :default => false

  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validate :email_uniqueness

  scope :pending, where(:status => 'pending', :deleted => false)
  scope :recent, order_by([:created_at,:desc])

  belongs_to :user
  belongs_to :startup

  before_create :set_status
  after_create :generate_uid

  def generate_uid
    require "digest/sha1"
    self.unique_id = Digest::SHA1.hexdigest(Time.now.to_s)
    self.save
  end

  def set_status
    self.status = "pending"
  end

  def email_uniqueness
    self.email.downcase!
    if self.new_record?
      existing_invitation = Invitation.where(:email => self.email, :startup_id => self.startup_id, :deleted => false).first
      if existing_invitation.present?
        if existing_invitation.status == "pending"
          errors.add(:email, "You cannot invite a user who has already been invited.")
        end
      end

      #If there is such user already existing in that organization
      existing_user = self.startup.team.users.where(:email => self.email)
      if existing_user.present?
        errors.add(:email, "You cannot invite a user who is already a part of your organization.")
      end
    end
  end
  
  def to_param
    self.unique_id.to_s
  end

end
