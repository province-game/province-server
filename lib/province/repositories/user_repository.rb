class UserRepository < Hanami::Repository
  associations do
    has_many :game_players
    has_many :games, through: :game_players
  end

  def authenticate(auth_hash)
    info = auth_hash[:info]
    attributes = { name: info[:name], email: info[:email], google_id: auth_hash[:uid] }

    user = users.where(google_id: attributes[:google_id]).first
    
    if user.nil?
      create User.new(attributes)
    else
      update user.id, attributes
    end
  end
end
