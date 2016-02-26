
require "rails_admin_comments/version"

require 'mongoid'
require 'mongoid_userstamp'

require 'rails_admin/config/actions'
require 'rails_admin/config/model'

module RailsAdminComments
  class << self
    def orm
      :mongoid
      # if defined?(::Mongoid)
      #   :mongoid
      # else
      #   :active_record
      # end
    end

    def mongoid?
      orm == :mongoid
    end

    def active_record?
      orm == :active_record
    end
  end

  autoload :Mongoid,           "rails_admin_comments/mongoid"
  # autoload :RailsAdminConfig,  "rails_admin_comments/rails_admin_config"
end


require "rails_admin_comments/engine"

require 'rails_admin_comments/configuration'
require 'rails_admin_comments/action'
# require 'rails_admin_comments/model'
require 'rails_admin_comments/helper'
