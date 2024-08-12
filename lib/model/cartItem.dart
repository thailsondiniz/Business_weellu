import 'package:flutter_project_business/model/item_class.dart';

class CartItem {
  final Item itemsCart;
  int quantity;

  CartItem({required this.itemsCart, this.quantity = 1});

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 0) {
      quantity--;
    }
  }

  // double get totalPrice => itemsCart.price * quantity;
}
