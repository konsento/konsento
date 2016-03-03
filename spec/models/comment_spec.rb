require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build :comment, :proposal_comment }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_presence_of :commentable }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :commentable }
  it { is_expected.to belong_to(:parent).class_name 'Comment' }
end
