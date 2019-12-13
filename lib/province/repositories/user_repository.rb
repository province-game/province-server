class UserRepository < Hanami::Repository
  def self.auth!(auth_hash)
    p auth_hash
    info = auth_hash[:info]
    google_id = info[:uid]
    attrs = {
      name:   info[:name],
      email:  info[:email],
    }

    user = query { where(google_id: attrs[:google_id]) }.first
    
    if user.present?
      user.update(attrs)
      update user
    else
      create(User.new(attrs.merge(google_id: google_id)))
    end
  end
end
