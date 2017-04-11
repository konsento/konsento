class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :proposal
  validates :user, presence: true
  validates :proposal, presence: true
  validates :opinion, presence: true, inclusion: { in: [-1, 0, 1] }

  scope :agree, -> { where(opinion: 1) }
  scope :disagree, -> { where(opinion: -1) }
end
