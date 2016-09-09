if RailsAdminComments.active_record?
  module RailsAdminComments
    class ModelComment < ActiveRecord::Base
    end
  end
end

module RailsAdminComments
  class ModelComment
    #binding.pry
    if RailsAdminComments.mongoid?
      include RailsAdminComments::ModelComments::Mongoid
    end

    if RailsAdminComments.active_record?
      self.table_name = "rails_admin_model_comments".freeze
    end

  end
end
