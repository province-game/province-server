class GamePlayerRepository < Hanami::Repository
  associations do
    belongs_to :game
    belongs_to :user, as: :player
  end
end
