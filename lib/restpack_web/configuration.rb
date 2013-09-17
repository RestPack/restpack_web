module RestPack::Web
  class Configuration
    attr_accessor :authentication_port

    def initialize
      @authentication_port = nil
    end
  end

  mattr_accessor :config
  @@config = Configuration.new

  def self.setup
    yield @@config
  end
end
