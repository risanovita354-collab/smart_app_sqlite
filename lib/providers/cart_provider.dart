import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Getter totalPrice
  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  void addToCart(CartItem item) {
    int index = _cartItems.indexWhere((i) => i.productId == item.productId);
    if (index >= 0) {
      _cartItems[index].quantity += 1;
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void updateQuantity(String id, int delta) {
    int index = _cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _cartItems[index].quantity += delta;
      if (_cartItems[index].quantity <= 0) {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Method clearCart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}