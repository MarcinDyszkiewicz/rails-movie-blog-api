require 'rails_helper'

RSpec.describe Post, type: :model do
  # Association test
  # it { should belong_to(:user) }
  # Validation test
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:image) }

end
