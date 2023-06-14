class Order {
  String model;
  String color;
  String mdf;
  int height;
  int width;
  String type;
  int modelId;
  int colorId;
  int mdfId;

  Order({
    required this.model,
    required this.color,
    required this.mdf,
    required this.height,
    required this.width,
    required this.type,
    required this.modelId,
    required this.colorId,
    required this.mdfId,
  });

  Order copyWith({
    String? model,
    String? color,
    String? mdf,
    int? height,
    int? width,
    String? type,
    int? modelId,
    int? colorId,
    int? mdfId,
  }) {
    return Order(
      model: model ?? this.model,
      color: color ?? this.color,
      mdf: mdf ?? this.mdf,
      height: height ?? this.height,
      width: width ?? this.width,
      type: type ?? this.type,
      modelId: modelId ?? this.modelId,
      colorId: colorId ?? this.colorId,
      mdfId: mdfId ?? this.mdfId,
    );
  }

  Order.fromJson(Map<String, dynamic> json)
      : model = json['model'],
        color = json['color'],
        mdf = json['mdf'],
        height = json['height'],
        width = json['width'],
        type = json['type'],
        modelId = json['modelId'],
        colorId = json['colorId'],
        mdfId = json['mdfId'];

  Map<String, dynamic> toJson() => {
        'model': model,
        'color': color,
        'mdf': mdf,
        'height': height,
        'width': width,
        'type': type,
        'modelId': modelId,
        'colorId': colorId,
        'mdfId': mdfId,
      };
}
