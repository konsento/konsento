require 'rails_helper'

RSpec.describe Proposal, type: :model do
  subject { build :proposal }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :section }
  it { is_expected.to belong_to(:parent).class_name 'Proposal' }
  it { is_expected.to have_many :votes }
end
