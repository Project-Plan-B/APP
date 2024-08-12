import 'package:plan_b/src/domain/study/entity/study_entity.dart';

class LaundryModel {
  final List<LaundryEntity> laundryList;

  const LaundryModel({
    required this.laundryList,
  });

  LaundryModel copyWith({List<LaundryEntity>? laundryList}) {
    return LaundryModel(
      laundryList: laundryList ?? this.laundryList,
    );
  }
}
