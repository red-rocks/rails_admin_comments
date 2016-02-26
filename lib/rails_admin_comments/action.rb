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
            @config = ::RailsAdminComments::Configuration.new @abstract_model

            if params['id'].present?
              @comments = @object.rails_admin_comments.by_date.enabled
              if request.get?
                render action: @action.template_name

              elsif request.post?
                begin
                  if params['rails_admin_comments_comment'].present?
                    if params['rails_admin_comments_comment']['id'].present?
                      @comment = @object.rails_admin_comments.find(params['rails_admin_comments_comment']['id'])
                    end
                    @comment = @object.rails_admin_comments.new if @comment.nil?

                    @comment.content = params['rails_admin_comments_comment']['content']

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
          [:get, :post]
        end
      end
    end
  end
end
