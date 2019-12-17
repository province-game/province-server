module Api
  module Controllers
    module Sessions
      class Failure
        include Api::Action
        include JSONAPI::Hanami::Action

        def call(_params)
          self.data = errors
        end
      end
    end
  end
end
