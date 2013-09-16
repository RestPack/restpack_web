require 'encrypted_cookie'

module RestPack::Web::Rack
  class Session < Rack::Session::EncryptedCookie

  end
end
