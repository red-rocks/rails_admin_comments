RailsAdmin.config do |config|
  config.excluded_models ||= []
  config.excluded_models << [
      'RailsAdminComments::Comment'
  ]
  config.excluded_models.flatten!
end

# [required] fix for timezones to be displayed in local time instead of UTC
module RailsAdmin
  module Config
    module Fields
      module Types
        class Datetime
          def value
            bindings[:object].send(name)
          end
        end
      end
    end
  end
end
