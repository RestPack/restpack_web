module RestPack::Web
  class Context
    attr_accessor :domain, :application, :user

    def initialize(env)
      restpack = env['restpack']

      if restpack
        @domain = restpack[:domain]
        @application = restpack[:application]
        @user = restpack[:user]
      end
    end

    def is_authenticated?
      !@user.nil?
    end

    def home_domain
      "www.#{@domain[:identifier]}"
    end

    def auth_domain
      "auth.#{@domain[:identifier]}"
    end

    def logout_url(next_url = nil) #TODO: GJ: whitelist the next_url
      next_url ||= "http://#{home_domain}/"
      "http://#{auth_domain}/auth/logout?next=#{next_url}"
    end

    def login_url(provider = :twitter, next_url = nil)
      next_url ||= "http://#{home_domain}/"
      "http://#{auth_domain}/auth/#{provider}?next=#{next_url}"
    end
  end
end
