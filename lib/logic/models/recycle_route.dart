class RecycleRoute {
  final int wasteNodeId;
  final int localSortId;
  final int regionalSortId;
  final int regionalRecycleId;

  final double totalScore;
  final double totalDistance;
  final double plasticLost;

  RecycleRoute({
    required this.wasteNodeId,
    required this.localSortId,
    required this.regionalSortId,
    required this.regionalRecycleId,
    required this.totalScore,
    required this.totalDistance,
    required this.plasticLost,
  });

  List<int> toList() {
    return [
      wasteNodeId,
      localSortId,
      regionalSortId,
      regionalRecycleId,
    ];
  }
}