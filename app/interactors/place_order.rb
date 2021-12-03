class PlaceOrder
  include Interactor::Organizer

  organize MakePayment, CreateOrder, SetOrderedItems
end
