import 'package:flutter/material.dart';
import '../../models/products.dart';
import '../../models/cart_item.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _selectedItem = {};

  Map<String, CartItem> _items = {};

  Map<String, CartItem> switchToSelected() {
    return _selectedItem = _items;
  }

  int get productCount {
    return _items.length;
  }

  int get selectedItemCount {
    return _selectedItem.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Map<String, CartItem> get productList {
    return _items;
  }

  Map<String, CartItem> get selectedProductList {
    return _selectedItem;
  }

  List<CartItem> get selectedProducts {
    return _selectedItem.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  Iterable<MapEntry<String, CartItem>> get selectedProductEntries {
    return {..._selectedItem}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.giasp * cartItem.soluongsp;
    });
    return total;
  }

  double get selectedItemTotalAmount {
    var total = 0.0;
    _selectedItem.forEach((key, value) {
      total += value.giasp * value.soluongsp;
    });
    return total;
  }

  String get getMa {
    String ma = '';
    _items.forEach((key, value) {
      ma = value.ma;
    });
      print(_items.length);
    return ma;
  }

  void addItem(Product product, int quantily, String ma) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!,
          (value) => value.copyWith(soluongsp: value.soluongsp + 1));
    } else {
      _items.putIfAbsent(
          product.id!,
          () => CartItem(
              id: product.id!,
              tensp: product.product_Ten,
              giasp: product.product_Price,
              ma: ma,
              // hinhsp: product.hinhsp,
              soluongsp: quantily > 1 ? quantily : 1));
    }
    // ignore: avoid_print
    _items.forEach((key, value) => print(value.ma),);
    notifyListeners();
  }

  void addSelectedItem(String productId, CartItem cart) {
    _selectedItem.putIfAbsent(
        productId,
        () => CartItem(
            id: 'c${DateTime.now().toIso8601String()}',
            tensp: cart.tensp,
            soluongsp: cart.soluongsp,
            ma: cart.ma,
            giasp: cart.giasp));
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removerSelectItem(String productId) {
    _selectedItem.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.soluongsp as num > 1) {
      _items.update(
          productId, (value) => value.copyWith(soluongsp: value.soluongsp - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void clearSelectedItem(bool selecAll, [Map<String, CartItem>? item]) {
    selecAll ? _selectedItem = {} : _selectedItem = {};
    item?.forEach((key, value) => _items.remove(key));
    notifyListeners();
  }
}
