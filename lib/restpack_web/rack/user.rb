require 'restpack_user_service'
require 'restpack_account_service'

module RestPack::Web::Rack
  class User
    def initialize(app)
      @app = app
    end

    def call(env)
      session = env["restpack.session"]
      user_id = session[:user_id]
      account_id = session[:account_id]

      if user_id && account_id
        response = Commands::Users::User::Get.run({
          id: user_id,
          application_id: env['restpack'][:application_id]
        })

        raise "Error getting user" unless response.success?
        env['restpack'][:user] = response.result[:users][0]

        response = Commands::Accounts::Account::Get.run({
          id: account_id,
          application_id: env['restpack'][:application_id]
        })
        raise "Error getting account" unless response.success?
        env['restpack'][:account] = response.result[:accounts][0]
      end

      @app.call(env)
    end
  end
end
