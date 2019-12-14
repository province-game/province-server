module Api
  module Controllers
    module Sessions
      class New
        include Api::Action

        def call(_params)
          user = UserRepository.new.authenticate(auth_hash)
          warden.set_user user
          redirect_to '/'
        end

        private

        def auth_hash
          request.env['omniauth.auth']
        end

        def warden
          request.env['warden']
        end
      end
    end
  end
end
