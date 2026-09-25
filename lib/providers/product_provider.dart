import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'Mouse Wireless',
      price: 150000,
      description: 'Mouse Wireless',
      imageUrl: 'assets/images/mousse.png',
    ),
    Product(
      id: '2',
      name: 'Keyboard Gaming',
      price: 350000,
      description: 'Keyboard Gaming',
      imageUrl: 'assets/images/keyboard.png',
    ),
    Product(
      id: '3',
      name: 'Headset Bluetooth', // Nama disesuaikan
      price: 250000,
      description: 'Headset Bluetooth',
      imageUrl: 'assets/images/headset bluethoot.png', // Sesuai nama file di folder kamu
    ),
    Product(
      id: '4',
      name: 'Monitor PC',
      price: 1200000,
      description: 'Monitor PC',
      imageUrl: 'assets/images/monitor.png',
    ),
    Product(
      id: '5',
      name: 'Flashdisk',
      price: 80000,
      description: 'Flashdisk USB',
      imageUrl: 'assets/images/flashdisk.png',
    ),
    Product(
      id: '6',
      name: 'Webcam',
      price: 200000,
      description: 'Webcam HD',
      imageUrl: 'assets/images/webcam.png',
    ),
  ];

  List<Product> _filteredProducts = [];

  ProductProvider() {
    _filteredProducts = List.from(_allProducts);
  }

  List<Product> get products => _filteredProducts;

  void addProduct(Product product) {
    _allProducts.add(product);
    _filteredProducts = List.from(_allProducts);
    notifyListeners();
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      _filteredProducts = _allProducts
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}