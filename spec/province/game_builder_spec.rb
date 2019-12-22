RSpec.describe Province::GameBuilder do
  context '#build' do
    subject(:build_game) { described_class.new.build(creator: creator, players: players) }

    context 'with creator' do
      let(:creator) { Fabricate.create(:user) }
      let(:players) { [creator, player] }

      context 'with players' do
        let(:player) { Fabricate.create(:user) }

        it 'creates game' do
          expect{
            game = build_game
            expect(game.class).to eq Game
          }.to change{ GameRepository.new.all.size }.from(0).to(1)
        end

        it 'creates game players' do
          expect{ build_game }.to change{ GamePlayerRepository.new.all.size }.from(0).to(2)
        end
      end

      context 'without players' do
        let(:players) { [] }

        it 'raises an exception' do
          expect{ build_game }.to raise_exception{ Province::GameBuilder::NoPlayersError }
        end
      end
    end

    context 'without creator' do
      let(:creator) { nil }
      let(:players) { [] }

      it 'raises an exception' do
        expect{ build_game }.to raise_exception{ Province::GameBuilder::NoCreatorError }
      end
    end
  end
end
