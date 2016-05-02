require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { build :location }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_numericality_of :total_votes_percent }
  it { is_expected.to validate_numericality_of :agree_votes_percent }
  it { is_expected.to belong_to(:parent).class_name 'Location' }
end
