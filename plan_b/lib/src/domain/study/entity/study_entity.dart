import 'package:plan_b/main.dart';

class LaundryEntity {
  final int id;
  final CurrentState state;
  final RoomName roomName;

  const LaundryEntity({
    required this.id,
    required this.state,
    required this.roomName,
  });
}
