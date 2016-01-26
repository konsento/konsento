class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscriptable, polymorphic: true, touch: true

  validate :user_has_join_requirements?

  private
  def user_has_join_requirements?
    join_requirements = self.subscriptable.join_requirements
    has_all_join_requirements = join_requirements.all? do |j|
      RequirementValue.find_by(user: self.user, join_requirement: j)
    end
    errors.add(:base, 'Usuário não possui todos os requerimentos.') unless has_all_join_requirements
  end
end
