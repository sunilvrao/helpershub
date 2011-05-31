class Profile
  include Mongoid::Document

  has_and_belongs_to_many :professions
end
