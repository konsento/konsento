class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscriptable, polymorphic: true, touch: true

  validates :user, uniqueness: {scope: [:subscriptable_id, :subscriptable_type]}
  validate :user_has_join_requirements?

  private

  def user_has_join_requirements?
    join_requirements = subscriptable.join_requirements

    has_all_join_requirements = join_requirements.all? do |j|
      user.requirement_values.exists? join_requirement: j
    end

    unless has_all_join_requirements
      errors.add(:base, 'Usuário não possui todos os requerimentos.')
    end
  end
end
