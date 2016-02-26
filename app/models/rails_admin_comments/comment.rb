if RailsAdminComments.active_record?
  module RailsAdminComments
    class Comment < ActiveRecord::Base
    end
  end
end

module RailsAdminComments
  class Comment
    #binding.pry
    if RailsAdminComments.mongoid?
      include RailsAdminComments::Mongoid
    end

    if RailsAdminComments.active_record?
      self.table_name = "rails_admin_comments"
    end
      
  end
end
