class CartItem {
  final String id;
  final String ma;
  final String tensp;
  late final int soluongsp;
  final int giasp;
  final String hinhsp;

  CartItem(
      {required this.id,
      required this.tensp,
      required this.soluongsp,
      required this.giasp,
      required this.ma,
      this.hinhsp = ''});
  CartItem copyWith(
      {String? id, String? tensp, int? soluongsp, int? giasp, String? hinhsp, String? ma}) {
    return CartItem(
        id: id ?? this.id,
        tensp: tensp ?? this.tensp,
        soluongsp: soluongsp ?? this.soluongsp,
        ma: ma ?? this.ma,
        giasp: giasp ?? this.giasp,
        hinhsp: hinhsp ?? this.hinhsp);
  }
}
