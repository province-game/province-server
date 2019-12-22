RSpec.describe Api::Controllers::Sessions::New, type: :action do
  let(:action) { described_class.new }
  let(:params) { {} }
  let(:warden) { WardenMock.new }
  let(:email) { 'user@example.com' }
  let(:name) { 'User' }
  let(:uid) { '001' }
  let(:auth_hash) { { info: { email: email, name: name }, uid: uid } }

  before do
    expect_any_instance_of(described_class).to receive(:auth_hash).and_return(auth_hash)
    expect_any_instance_of(described_class).to receive(:warden).twice.and_return(warden)
  end


  context 'when user does not exist' do
    it 'creates user' do
      expect {
        response = action.call(params)

        expect(response[0]).to eq 200
        expect(response[1]['Content-Type']).to eq 'application/json; charset=utf-8'
        expect(JSON.parse(response[2].first).slice('email', 'name', 'google_id')).
          to eq({ 'email' => email, 'name' => name, 'google_id' => uid })
      }.to change{ UserRepository.new.all.size }.from(0).to(1)
    end
  end

  context 'when user not exist' do
    before do
      UserRepository.new.create(email: email, name: 'Name to change', google_id: uid)
    end

    it 'updates user' do
      expect {
        response = action.call(params)

        expect(response[0]).to eq 200
        expect(response[1]['Content-Type']).to eq 'application/json; charset=utf-8'
        expect(JSON.parse(response[2].first).slice('email', 'name', 'google_id')).
          to eq({ 'email' => email, 'name' => name, 'google_id' => uid })
      }.not_to change{ UserRepository.new.all.size }
    end
  end
end
