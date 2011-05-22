class Startup
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :url, :type=>String
  field :address, :type=>String
  field :country, :type=>String
  field :description, :type => String
  field :slug, :type=>String
  field :deleted, :type=>Boolean
  field :deleted_at, :type=>DateTime
  referenced_in :owner, :class_name=>'User'
  references_many :requests
  mount_uploader :logo, LogoUploader
  validates_presence_of :name, :url
  validates_uniqueness_of :slug
  before_create :set_slug


  default_scope where(:deleted_at=>nil)

  def soft_delete
    self.deleted=true
    self.deleted_at=DateTime.now
    self.save
  end

  def set_slug
    unless self.slug
      slug_text = self.name.strip.downcase.gsub(/[^a-z0-9]+/,'-')
      count=0
      check_text = slug_text
      while(Startup.where(:slug=>check_text).count>0)
        count=count+1
        check_text = slug_text + "-#{count}"
      end
      self.slug = check_text
    end
  end
  def to_param
    self.slug
  end
end
