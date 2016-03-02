require 'rails_helper'

RSpec.describe Team, type: :model do
  subject { build :team }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :public }
  it { is_expected.to have_many :topics }
  it { is_expected.to have_many :team_invitations }
end
