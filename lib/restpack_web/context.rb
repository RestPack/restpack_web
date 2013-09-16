module RestPack::Web
  class Context
    attr_accessor :restpack

    def initialize(env)
      @restpack = env[:restpack]

      #TODO: GJ: add domain, application and user to context
    end
  end
end
