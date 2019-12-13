module Api
  module Controllers
    module Sessions
      class Failure
        include Api::Action

        def call(_params)
          status 404, 'Not found'
        end
      end
    end
  end
end
