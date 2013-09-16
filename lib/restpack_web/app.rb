module RestPack::Web
  class App
    def initialize(app)
      @app = app
    end

    def call(env)
      identifier = Rack::Request.new(env).host

      response = RestPack::Core::Service::Commands::Domain::ByIdentifier.run({
        identifier: identifier,
        includes: 'applications'
      })

      if response.status == :ok
        domain = response.result[:domains][0]
        application = response.result[:applications][0]
        env[:restpack] = {
          domain: domain,
          application: application
        }

        env['rack.session.options'] ||= {}
        env['rack.session.options'][:key] = 'restpack.session'
        env['rack.session.options'][:secret] = domain[:session_secret]
      else
        #TODO: GJ: add exception info to restpack context
        raise "[#{identifier}] is not a RestPack domain"
      end

      session[:c] ||= 0
      session[:c] = session[:c] + 1
      p session[:c]
      p "===================="

      add_user env

      @app.call(env)
    end

    private

    def add_user(env)
      session = env['rack.session']
      return unless session

      user_id = env['rack.session'][:user_id]

      # p env['rack.session'][:user_id]
      # p env['rack.session']['user_id']
      p env['rack.session']
      # p env['rack.session']



      p "TODO: #{user_id}"
    end
  end
end
