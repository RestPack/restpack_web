module RestPack::Web::Sinatra
  module App
    def self.included(base)
      base.use RestPack::Web::Rack::Domain
      base.use RestPack::Web::Rack::Session
      base.use RestPack::Web::Rack::User

      base.before do
        @restpack = RestPack::Web::Context.new(env)
      end
    end
  end
end
