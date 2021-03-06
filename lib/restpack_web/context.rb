module RestPack::Web
  class Context
    attr_accessor :domain, :application, :user, :account

    def initialize(env)
      restpack = env['restpack']

      if restpack
        @domain = restpack[:domain]
        @application = restpack[:application]
        @user = restpack[:user]
        @account = restpack[:account]
      end
    end

    def authenticated?
      !@user.nil?
    end

    def user_id
      authenticated? ? @user[:id] : nil
    end

    def account_id
      authenticated? ? @account[:id] : nil
    end

    def application_id
      @application[:id]
    end

    def domain_id
      @domain[:id]
    end

    def home_domain
      "www.#{@domain[:identifier]}"
    end

    def auth_domain
      "auth.#{@domain[:identifier]}"
    end

    def logout_url(next_url = nil)
      next_url ||= "http://#{home_domain}/"
      auth_url('/auth/logout', next_url)
    end

    def login_url(provider = :twitter, next_url = nil)
      auth_url("/auth/#{provider}", next_url)
    end

    def debug_info
      "todo"
    end

    private

    def auth_url(path, next_url = nil)
      #TODO: GJ: whitelist the next_url?
      #TODO: GJ: URI encode next_url?
      port = RestPack::Web.config.authentication_port

      port_part = port ? ":#{port}" : ""
      next_part = next_url ? "?next=#{next_url}" : ""

      "http://#{auth_domain}#{port_part}#{path}#{next_part}"
    end
  end
end
