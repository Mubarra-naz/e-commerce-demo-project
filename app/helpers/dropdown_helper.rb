module DropdownHelper
  def select_options(model_name, attr)
    symbol=attr.to_sym
    model_name.classify.constantize.all.map{ |item| [item[symbol], item[:id]] }
  end
end
