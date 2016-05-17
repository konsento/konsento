require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject { build :notification }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :key }
  it { is_expected.to validate_presence_of :data }
  it { is_expected.to validate_presence_of :notifiable }
  it { is_expected.to validate_inclusion_of(:read).in_array([true, false]) }
  it { is_expected.to belong_to :user }
end
