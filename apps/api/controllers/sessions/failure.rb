module Api
  module Controllers
    module Sessions
      class Failure
        include Api::Action
        accept :json

        def call(_params)
          status 426, [].to_json
        end
      end
    end
  end
end
