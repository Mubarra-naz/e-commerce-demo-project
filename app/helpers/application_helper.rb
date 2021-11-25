module ApplicationHelper
  def select_options(model_name, attribute)
    model_name.classify.constantize.pluck(attribute, :id)
  end
end
