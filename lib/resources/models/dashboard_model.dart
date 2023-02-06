class DashboardModel {
  String waiting;
  String process;
  String end;
  String total;
  String fake;
  String users;

  DashboardModel({
    required this.waiting,
    required this.process,
    required this.end,
    required this.fake,
    required this.total,
    required this.users,
  });

  factory DashboardModel.fromMap(Map<String, dynamic> value) {
    return DashboardModel(
      waiting: value['waiting'],
      process: value['process'],
      end: value['end'],
      fake: value['fake'],
      total: value['total'],
      users: value['users'],
    );
  }
}
