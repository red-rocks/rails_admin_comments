module RailsAdmin
  module Config
    module Actions
      class Comments < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          false
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          true
        end

        register_instance_option :route_fragment do
          'comments'
        end

        register_instance_option :controller do
          Proc.new do |klass|
            if params['id'].present?
              @config = ::RailsAdminComments::Configuration.new @abstract_model
              if request.get?
                @comments = @object.rails_admin_comments.by_date.enabled.for_user(current_user) || []
                render action: @action.template_name

              elsif request.post?
                begin
                  if params['rails_admin_comments_comment'].present?
                    if params['rails_admin_comments_comment']['id'].present?
                      @comment = @object.rails_admin_comments.find(params['rails_admin_comments_comment']['id'])
                    end
                    @comment = @object.rails_admin_comments.new if @comment.nil?

                    @comment.content = params['rails_admin_comments_comment']['content']
                    @comment.visible_for_user_ids = params['rails_admin_comments_comment']['visible_for_user_ids']

                    if @comment.save
                      @comment = nil
                      @message = "<strong class='success'>#{I18n.t('admin.actions.comments.success')}!</strong>"

                    else
                      @message = []
                      @message << "<strong class='error'>#{I18n.t('admin.actions.comments.error')}!</strong>"
                      @comment.errors.each do |e|
                        @message << "<p>#{e.message}</p>"
                      end
                      @message = @message.join
                    end
                  else
                    @message = "<strong class='error'>#{I18n.t('admin.actions.comments.error')}</strong>:<p>#{I18n.t('admin.actions.comments.error_no_data')}</p>"
                  end

                rescue Exception => e
                  @message = "<strong class='error'>#{I18n.t('admin.actions.comments.error')}</strong>: #{e}"
                end

                render action: @action.template_name
              end
            end
          end
        end

        register_instance_option :link_icon do
          'icon-comment'
        end

        register_instance_option :http_methods do
          [:get, :post, :delete]
        end
      end
    end
  end
end



module RailsAdmin
  module Config
    module Actions
      class ModelComments < Comments
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection? do
          true
        end

        register_instance_option :member? do
          false
        end

        register_instance_option :route_fragment do
          'model_comments'
        end

        register_instance_option :controller do
          Proc.new do |klass|
            @config = ::RailsAdminComments::Configuration.new @abstract_model
            @model = @abstract_model.model
            if request.get?
              @comments = @model.rails_admin_model_comments.by_date.enabled.for_user(current_user) || []
              render action: @action.template_name

            elsif request.post?
              begin
                if params['rails_admin_comments_model_comment'].present?
                  if params['rails_admin_comments_model_comment']['id'].present?
                    @comment = @model.rails_admin_model_comments.find(params['rails_admin_comments_model_comment']['id'])
                  end
                  @comment ||= @model.rails_admin_model_comments.new

                  @comment.content = params['rails_admin_comments_model_comment']['content']
                  @comment.visible_for_user_ids = params['rails_admin_comments_model_comment']['visible_for_user_ids']

                  if @comment.save
                    @comment = nil
                    @message = "<strong class='success'>#{I18n.t('admin.actions.model_comments.success')}!</strong>"

                  else
                    @message = []
                    @message << "<strong class='error'>#{I18n.t('admin.actions.model_comments.error')}!</strong>"
                    @comment.errors.each do |e|
                      @message << "<p>#{e.message}</p>"
                    end
                    @message = @message.join
                  end
                else
                  @message = "<strong class='error'>#{I18n.t('admin.actions.model_comments.error')}</strong>:<p>#{I18n.t('admin.actions.model_comments.error_no_data')}</p>"
                end

              rescue Exception => e
                @message = "<strong class='error'>#{I18n.t('admin.actions.comments.error')}</strong>: #{e}"
              end

              render action: @action.template_name

            elsif request.delete?
              if params['rails_admin_comments_model_comment']['id'].present?
                @comment = @model.rails_admin_model_comments.find(params['rails_admin_comments_model_comment']['id'])
              end
              if @comment and @comment.destroy
                @comment = nil
                @message = "Удалено"
              else
                @message = "Удаление не удалось"
              end
              render action: @action.template_name
            end
          end
        end

        register_instance_option :link_icon do
          'icon-comment'
        end
      end
    end
  end
end
