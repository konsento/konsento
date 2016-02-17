class Subscription < ActiveRecord::Base
  TEAM_ROLES = [
    'default',
    'admin'
  ]

  belongs_to :user
  belongs_to :subscriptable, polymorphic: true, touch: true

  validates :user, uniqueness: {scope: [:subscriptable_id, :subscriptable_type]}
  validates :role, inclusion: {in: TEAM_ROLES}, if: -> (s) { s.subscriptable_type == 'Team' } 
  validate :user_has_join_requirements?
  validate :left_with_at_least_one_admin?

  def self.roles_for_select
    TEAM_ROLES.map { |r| [I18n.t("subscription.team_roles.#{r}"), r] }
  end

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

  def left_with_at_least_one_admin?
    if role != 'admin' && subscriptable.subscriptions.where(role: 'admin').count < 2
      errors.add(:base, 'Deve ter pelo menos um admin')
    end
  end
end
