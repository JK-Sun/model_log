RSpec.describe ModelLog do
  it "has a version number" do
    expect(ModelLog::VERSION::STRING).not_to be nil
  end
end
