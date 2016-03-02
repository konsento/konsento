require 'rails_helper'

RSpec.describe Invitation, type: :model do
  subject { build :invitation }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :token }
  it { is_expected.to validate_presence_of :registered }
  it { is_expected.to belong_to :user }
end
