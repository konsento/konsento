require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :proposal }
  it { is_expected.to validate_presence_of :opinion }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :proposal }
  it { is_expected.to validate_inclusion_of(:opinion).
    in_array([-1, 0, 1])
  }
end
