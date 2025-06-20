class MealPlan {
  int? id;
  String mealType;
  String food;
  String preference;
  String quantity;
  String unit;
  String brand;

  MealPlan({
    this.id,
    required this.mealType,
    required this.food,
    required this.preference,
    required this.quantity,
    required this.unit,
    required this.brand,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'mealType': mealType,
    'food': food,
    'preference': preference,
    'quantity': quantity,
    'unit': unit,
    'brand': brand,
  };

  factory MealPlan.fromMap(Map<String, dynamic> map) {
    return MealPlan(
      id: map['id'],
      mealType: map['mealType'],
      food: map['food'],
      preference: map['preference'],
      quantity: map['quantity'],
      unit: map['unit'],
      brand: map['brand'],
    );
  }
}
