module Province
  class GameBuilder
    class NoCreatorError < StandardError; end
    class NoPlayersError < StandardError; end

    def build(creator:, players: )
      raise NoCreatorError if creator.nil?
      raise NoPlayersError if players.empty?
      game = Game.new(creator_id: creator.id)
      game_record = GameRepository.new.create(game)
      players.each do |player|
        game_player = GamePlayer.new(game_id: game_record.id, player_id: player.id)
        GamePlayerRepository.new.create(game_player)
      end
      game
    end
  end
end
