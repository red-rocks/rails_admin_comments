module RailsAdminComments
  module Comments
    module Mongoid
      extend ActiveSupport::Concern
      included do
        include ::Mongoid::Document
        include ::Mongoid::Timestamps::Short
        include ::Mongoid::Userstamp

        belongs_to :rails_admin_commentable, polymorphic: true, optional: true

        store_in collection: "rails_admin_comments".freeze

        field :enabled, type: ::Mongoid::VERSION.to_i < 4 ? Boolean : ::Mongoid::Boolean, default: true
        scope :enabled, -> { where(enabled: true) }

        scope :by_date, -> { order([:c_at, :asc]) }

        field :content
        validates_presence_of :content


        has_and_belongs_to_many :visible_for_users, class_name: "User", inverse_of: nil
        scope :for_user, ->(user) {
          any_of({visible_for_user_ids: user}, {visible_for_user_ids: nil}, {visible_for_user_ids: []})
        }


        has_and_belongs_to_many :read_by_users, class_name: "User", inverse_of: nil
        scope :unread, ->(user) {
          where("$and" => [{:creator_id.ne => user}, {:read_by_user_ids.ne => user}])
        }

        def unread_by?(user)
          !read_by?(user)
        end
        def read_by?(user)
          read_by_user_ids.include?(user.id) if user
          # read_by_user_ids.include?(user.id) or creator == user if user
        end
        def read_by(user)
          self.read_by_user_ids << user.id if user and unread_by?(user)
        end
        def read_by!(user)
          self.read_by(user) and self.save if user
        end

      end

      class_methods do
        def mark_read_by(comment_ids, user)
          if user
            unread.where("$and" => [{:id.in => comment_ids}]).add_to_set(read_by_user_ids: user.id)
          end
        end
      end

    end
  end
end
