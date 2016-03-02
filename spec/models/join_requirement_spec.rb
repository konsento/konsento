require 'rails_helper'

RSpec.describe JoinRequirement, type: :model do
  subject { build :join_requirement }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_many :requirements }
  it { is_expected.to have_many :requirement_values }
end
