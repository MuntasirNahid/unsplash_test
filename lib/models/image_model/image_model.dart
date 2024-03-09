class ImageModel {
  final String id;
  final String? description;
  final String raw;
  final String full;
  final String regular;
  final String small;

  ImageModel({
    required this.id,
    required this.description,
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "description": this.description,
      "raw": this.raw,
      "full": this.full,
      "regular": this.regular,
      "small": this.small,
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      description: json['alt_description'] ?? "description",
      raw: json['urls']['raw'],
      full: json['urls']['full'],
      regular: json['urls']['regular'],
      small: json['urls']['small'],
    );
  }
}
