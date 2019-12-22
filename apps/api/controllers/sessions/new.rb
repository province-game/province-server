module Api
  module Controllers
    module Sessions
      class New
        include Api::Action

        def call(_params)
          user = UserRepository.new.authenticate(auth_hash)
          warden.set_user user
          status 200, user.to_h.to_json
        end

        private

        def auth_hash
          request.env['omniauth.auth']
        end
      end
    end
  end
end
