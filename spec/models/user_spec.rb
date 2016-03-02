require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_confirmation_of :password }
  it { should validate_numericality_of(:available_invitations).only_integer }
end
