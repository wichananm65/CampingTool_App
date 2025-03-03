class Campingtool {
  String toolName;
  int quantity;
  DateTime? date;
  String? category;

  Campingtool({
    required this.toolName,
    required this.quantity,
    this.date,
    this.category,
  });
}
