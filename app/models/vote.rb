class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal

  validate :opinion_is_valid

  def opinion_is_valid
    unless opinion == -1 || opinion == 1
      errors.add(:opinion, "Opinion not valid")
    end
  end
end
