class SetOrderedItems
  include Interactor

  def call
    order = Order.find(context.order.id)
    context.fail!(error: "couldn't add items to order") unless order.add_items(context.items)
  end
end
