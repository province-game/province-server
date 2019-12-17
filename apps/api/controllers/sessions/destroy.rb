module Api
  module Controllers
    module Sessions
      class Destroy
        include Api::Action

        def call(_params)
          warden.logout
          status 200, {}
        end
      end
    end
  end
end
