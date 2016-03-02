require 'rails_helper'

RSpec.describe Section, type: :model do
  subject { build :section }

  it { is_expected.to validate_presence_of :topic }
  it { is_expected.to belong_to :topic }
  it { is_expected.to have_many :proposals }
  it { is_expected.to validate_presence_of :index }
  it { should validate_numericality_of(:index).only_integer }
end
