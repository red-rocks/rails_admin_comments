RailsAdmin::ApplicationHelper.class_eval do
  def wording_for(label, action = @action, abstract_model = @abstract_model, object = @object)
    model_config = abstract_model.try(:config)
    object = abstract_model && object.is_a?(abstract_model.model) ? object : nil
    action = RailsAdmin::Config::Actions.find(action.to_sym) if action.is_a?(Symbol) || action.is_a?(String)

    rails_admin_comments_count = nil
    if object and object.respond_to?(:rails_admin_comments)
      rails_admin_comments_count = object.rails_admin_comments.enabled.for_user(current_user).count
    end

    capitalize_first_letter I18n.t(
      "admin.actions.#{action.i18n_key}.#{label}",
      model_label: model_config && model_config.label,
      model_label_plural: model_config && model_config.label_plural,
      object_label: model_config && object.try(model_config.object_label_method),
      rails_admin_comments_count: rails_admin_comments_count,
    )
  end
end
