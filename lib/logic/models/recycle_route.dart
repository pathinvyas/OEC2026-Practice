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
    return [wasteNodeId, localSortId, regionalSortId, regionalRecycleId];
  }
}

class RecycleRouteManager {
  final List<RecycleRoute> routes = [];

  double totalScore = 0;
  double totalDistance = 0;
  double totalPlasticRecycled = 0;
  double totalPlasticLost = 0;

  void add(RecycleRoute recycleRoute) {
    routes.add(recycleRoute);

    totalScore += recycleRoute.totalScore;
    totalDistance += recycleRoute.totalDistance;
    totalPlasticRecycled += recycleRoute.plasticLost;
    totalPlasticLost += recycleRoute.plasticLost;
  }
}
