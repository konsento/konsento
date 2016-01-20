class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal
  validates :opinion, inclusion: { in: [-1, 0, 1] }

  scope :agree, -> { where(opinion: 1) }
end
