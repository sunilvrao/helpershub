class Follow
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :followable, :polymorphic=>true
end
