class Meal {
  final int id;
  final String name;
  final double price;
  int quantity;

  Meal({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 0,
  });

  double get totalPrice => price * quantity;
}
