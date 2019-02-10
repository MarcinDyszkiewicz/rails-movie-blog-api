require 'rails_helper'

RSpec.describe Movie, type: :model do
  # Association test
  it { should have_many(:posts) }
  # Validation test
  it { should validate_presence_of(:slug) }
end

# Test suite for the Item model
# RSpec.describe Movie, type: :model do
#   mo
#
#
#   vie { described_class.new }
#
#   it "is valid with valid attributes" do
#     movie.title = "Anything"
#     movie.year = 2008
#     expect(movie).to be_valid
#   end
# end
