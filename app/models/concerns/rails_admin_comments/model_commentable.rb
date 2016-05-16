module RailsAdminComments
  module ModelCommentable
    extend ActiveSupport::Concern

    module ClassMethods
      def rails_admin_model_comments
        RailsAdminComments::ModelComment.where(model_name: self)
      end
    end

  end
end
