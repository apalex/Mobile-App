class Chart {
  int time;
  double? open;
  double? high;
  double? low;
  double? close;

  Chart({required this.time, required this.open, required this.high, required this.low, required this.close});

  factory Chart.fromJson(List list) {
    return Chart(
      time: list[0] == null ? null : list[0]!,
      open: list[1] == null ? null : list[1]!,
      high: list[2] == null ? null : list[2]!,
      low: list[3] == null ? null : list[3]!,
      close: list[4] == null ? null : list[4]!,
    );
  }

}