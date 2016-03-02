require 'rails_helper'

RSpec.describe RequirementValue, type: :model do
  subject { build :requirement_value }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :join_requirement }
  it { is_expected.to validate_presence_of :value }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :join_requirement }
end
