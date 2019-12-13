module Api
  module Controllers
    module Sessions
      class Destroy
        include Api::Action

        def call(_params)
          warden.logout
          redirect_to '/'
        end
      end
    end
  end
end
