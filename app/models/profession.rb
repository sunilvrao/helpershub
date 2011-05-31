class Vertical
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :request_count, :type => Integer, :default=>0
  field :startup_count, :type => Integer, :default=>0
  field :slug, :type=>String
  validates_presence_of :name
  validates_uniqueness_of :name, :slug
  before_create :set_slug
  has_and_belongs_to_many :profiles

  def set_slug
    unless self.slug
      slug_text = self.name.strip.downcase.gsub(/[^a-z0-9]+/,'-')
      count=0
      check_text = slug_text
      while(Profession.where(:slug=>check_text).count>0)
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
