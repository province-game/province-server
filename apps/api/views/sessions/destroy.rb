module Api
  module Views
    module Sessions
      class Destroy
        include Api::View
        format :json

        def render
          { user: user }
        end
      end
    end
  end
end
