class Campingtool {
  int? keyID;
  String toolName;
  int quantity;
  DateTime? date;
  String? category;

  Campingtool({
    this.keyID,
    required this.toolName,
    required this.quantity,
    this.date,
    this.category,
  });
}
