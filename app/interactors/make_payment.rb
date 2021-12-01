class MakePayment
  include Interactor

  def call
    if(context.order_params[:payment_method] == Order::ONLINE)
      payment = PaymentProcessor.payment(context.order_params[:price], context.payment_method_nonce)

      if(payment.success?)
        context.payment = payment
      else
        context.fail!(error: payment.errors)
      end
    end
  end
end
