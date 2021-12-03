class CreateOrder
  include Interactor

  def call
    order = Order.create(context.order_params)

    if order.persisted?
      context.order = order
    else
      context.fail!(error: "error occured, couldn't create order")
    end
  end

  def rollback
    context.order.destroy
  end
end
