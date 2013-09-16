module RestPack::Web::Rails
  module Controller
    def self.included(base)
      base.send(:before_filter, :setup_restpack_context)
    end

    def setup_restpack_context
      @restpack = RestPack::Web::Context.new(request.env)
    end
  end
end
