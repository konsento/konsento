require 'rails_helper'

RSpec.describe Subscription, type: :model do
  subject { create :subscription, :location_subscription }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :role }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :subscriptable }
end
