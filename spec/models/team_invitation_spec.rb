require 'rails_helper'

RSpec.describe TeamInvitation, type: :model do
  subject { build :team_invitation }
  it { is_expected.to validate_presence_of :team }
  it { is_expected.to validate_presence_of :token }
  it { is_expected.to validate_inclusion_of(:accepted).in_array([true, false]) }
  it { is_expected.to belong_to :team }

end
