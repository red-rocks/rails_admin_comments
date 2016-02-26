module RailsAdminComments
  class Engine < ::Rails::Engine

    initializer "RailsAdminComments precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(rails_admin/rails_admin_comments.js rails_admin/rails_admin_comments.css)
    end

    initializer 'Include RailsAdminComments::Helper' do |app|
      ActionView::Base.send :include, RailsAdminComments::Helper
    end
  end
end
