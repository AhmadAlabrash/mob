class Milestone {
  dynamic id;
  final String name;
  final String? description;
  final num price;
  final num revision;
  final String dTime;
  Milestone({
    this.id,
    required this.name,
    this.description,
    required this.price,
    required this.revision,
    required this.dTime,
  });
}
