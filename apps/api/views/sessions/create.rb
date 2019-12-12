module Api
  module Views
    module Sessions
      class Create
        include Api::View
        format :json

        def render
          { user: user }
        end
      end
    end
  end
end
