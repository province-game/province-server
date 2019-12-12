module Api
  module Controllers
    module Sessions
      class Create
        include Api::Action
        expose :user

        def call(params)
          @user = {}
        end
      end
    end
  end
end