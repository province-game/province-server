class GameRepository < Hanami::Repository
  associations do
    belongs_to :user, as: :creator
    has_many :game_players
    has_many :users, as: :players, through: :game_players
  end
end
