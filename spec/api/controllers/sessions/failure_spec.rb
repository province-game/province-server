RSpec.describe Api::Controllers::Sessions::Failure, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:warden) { WardenMock.new }

  before do
    expect_any_instance_of(described_class).to receive(:warden).and_return(warden)
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 426
    expect(response[1]['Content-Type']).to eq 'application/json; charset=utf-8'
    expect(JSON.parse(response[2].first)).to eq({})
  end
end
