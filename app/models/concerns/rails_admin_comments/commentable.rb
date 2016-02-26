module RailsAdminComments
  module Commentable
    extend ActiveSupport::Concern
    included do
      has_many :rails_admin_comments, as: :rails_admin_commentable, class_name: "RailsAdminComments::Comment"
    end
  end
end
