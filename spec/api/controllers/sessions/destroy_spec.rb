RSpec.describe Api::Controllers::Sessions::Destroy, type: :action do
  let(:action) { described_class.new }
  let(:params) { {} }
  let(:warden) { WardenMock.new }

  before do
    expect_any_instance_of(described_class).to receive(:warden).twice.and_return(warden)
    expect(warden).to receive(:logout)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
    expect(response[1]['Content-Type']).to eq 'application/json; charset=utf-8'
    expect(JSON.parse(response[2].first)).to eq({})
  end
end
