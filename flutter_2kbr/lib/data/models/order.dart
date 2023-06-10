class Order {
  String pattern;
  String color;
  int thickness;
  int height;
  int width;

  Order({
    required this.pattern,
    required this.color,
    required this.thickness,
    required this.height,
    required this.width,
  });

  Order copyWith({
    String? pattern,
    String? color,
    int? thickness,
    int? height,
    int? width,
  }) {
    return Order(
      pattern: pattern ?? this.pattern,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }
}
