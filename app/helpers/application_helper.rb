module ApplicationHelper
  def select_options(model_name, attribute)
    symbol = attribute.to_sym
    model_name.classify.constantize.pluck(symbol, :id)
  end
end
