RSpec.describe Api::Controllers::Sessions::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { {} }

  it "is successful" do
    response = action.call(params)
    p response
    expect(response[0]).to be(200)
  end
end
