module DropdownHelper
  def select_options(model_name, attribute)
    options_from_collection_for_select(model_name.classify.constantize.all, "id", attribute)
  end
end
