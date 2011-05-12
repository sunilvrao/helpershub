class Startup
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :url, :type=>String
  field :address, :type=>String
  field :country, :type=>String
  field :description, :type => String
  field :slug, :type=>String
  referenced_in :owner, :class_name=>'User'
  mount_uploader :logo, LogoUploader
  validates_presence_of :name, :url
  validates_uniqueness_of :slug
  before_create :set_slug

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
