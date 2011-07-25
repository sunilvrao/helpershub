class Follow
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :followable, :polymorphic=>true

  paginates_per 5
end
