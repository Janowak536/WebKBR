class Order {
  String pattern;
  String color;
  int thickness;
  int height;
  int width;
  String type;

  Order({
    required this.pattern,
    required this.color,
    required this.thickness,
    required this.height,
    required this.width,
    required this.type,
  });

  Order copyWith({
    String? pattern,
    String? color,
    int? thickness,
    int? height,
    int? width,
    String? type,
  }) {
    return Order(
        pattern: pattern ?? this.pattern,
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        height: height ?? this.height,
        width: width ?? this.width,
        type: type ?? this.type);
  }

  Order.fromJson(Map<String, dynamic> json)
      : pattern = json['pattern'],
        color = json['color'],
        thickness = json['thickness'],
        height = json['height'],
        width = json['width'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'pattern': pattern,
        'color': color,
        'thickness': thickness,
        'height': height,
        'width': width,
        'type': type,
      };
}
