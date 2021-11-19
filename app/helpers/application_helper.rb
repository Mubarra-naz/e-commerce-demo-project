module ApplicationHelper
  def select_options(model_name, attribute)
    symbol = attribute.to_sym
    model_name.classify.constantize.all.map{ |item| [item[symbol], item[:id]] }
  end
end
