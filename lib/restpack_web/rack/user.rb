module RestPack::Web::Rack
  class User
    def initialize(app)
      @app = app
    end

    def call(env)
      session = env["restpack.session"]
      user_id = session[:user_id]


      p "----------------------"
      if user_id
        p "TODO: GJ: inject user #{user_id}"
       else
        p "Anonymous RestPack User"
      end
      p "----------------------"

      @app.call(env)
    end
  end
end
