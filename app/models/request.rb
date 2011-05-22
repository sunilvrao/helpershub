class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  field :description, :type=>String
  field :start_date, :type=>DateTime, :default=>DateTime.now
  field :end_date, :type=>DateTime, :default=>DateTime.now
  field :points, :type=>Integer
  field :active, :type=>Boolean, :default=>true
  field :status, :type=>String
  field :type, :type=>String
  field :views_count, :type=>Integer
  field :location,:type=>String
  field :slug, :type=>String
  belongs_to :startup
  belongs_to :owner, :class_name=>"User"
  has_and_belongs_to_many :categories
  has_many :commitments
  has_many :comments, :as=>:commentable
  validates_presence_of :title, :start_date, :end_date, :startup
  
  before_create :set_slug
  paginates_per 5
  def set_slug
    unless self.slug
      slug_text = self.title.strip.downcase.gsub(/[^a-z0-9]+/,'-')
      count=0
      check_text = slug_text
      while(Request.where(:slug=>check_text).count>0)
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
