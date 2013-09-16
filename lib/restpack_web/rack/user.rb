require 'restpack_user_service'

module RestPack::Web::Rack
  class User
    def initialize(app)
      @app = app
    end

    def call(env)
      session = env["restpack.session"]
      user_id = session[:user_id]

      if user_id
        response = RestPack::User::Service::Commands::User::Get.run({
          id: user_id,
          application_id: env['restpack'][:application_id]
        })

        if response.status == :ok
          user = response.result[:users][0]
          env['restpack'][:user] = user
        else
          #TODO: GJ: better exceptions based on response status
          raise "Error getting user"
        end
      end

      @app.call(env)
    end
  end
end
