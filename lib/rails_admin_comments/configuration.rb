module RailsAdminComments
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      @options ||= {}
    end

    protected
    def config
      ::RailsAdmin::Config.model(@abstract_model.model).comments || {}
    end
  end
end
