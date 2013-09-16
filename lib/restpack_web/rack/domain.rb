module RestPack::Web::Rack
  class Domain
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

        env['restpack'] ||= {}
        env['restpack'][:domain] = domain
        env['restpack'][:application] = application
        env['restpack'][:application_id] = application[:id]

        env['restpack.session.options'] ||= {}
        env['restpack.session.options'][:key] = 'restpack.session'
        env['restpack.session.options'][:secret] = domain[:session_secret]
        env['restpack.session.options'][:domain] = domain[:identifier]
      else
        #TODO: GJ: better exceptions based on response status
        raise "[#{identifier}] is not a RestPack domain"
      end

      @app.call(env)
    end
  end
end
