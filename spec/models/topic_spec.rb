require 'rails_helper'

RSpec.describe Topic, type: :model do
  subject { build :topic }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :location }
  it { is_expected.to belong_to :location }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :team }
  it { is_expected.to belong_to(:parent).class_name 'Topic' }
  it { is_expected.to have_many :sections }
  it { is_expected.to have_many :tags }
end
