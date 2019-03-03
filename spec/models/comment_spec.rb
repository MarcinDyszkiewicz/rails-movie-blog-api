require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to have_db_column(:commentable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:commentable_type).of_type(:string) }

  it { is_expected.to belong_to(:commentable) }
  it { is_expected.to belong_to(:user) }
end
