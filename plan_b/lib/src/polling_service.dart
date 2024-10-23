import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/data/home/data_source/remote/remote_home_data_source.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_bloc.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_event.dart';
import 'package:plan_b/src/pages/home_page/ui/view/home.dart';

class PollingService with ChangeNotifier {
  Timer? _timer;
  bool isPollingActive = false;

  void startPolling(BuildContext context, int id, int confusion) {
    if (isPollingActive) return; // 이미 실행 중이라면 중복 실행 방지
    isPollingActive = true;
    Home.count = 1;

    // RemoteApplyDataSource의 인스턴스 생성
    final remoteDataSource = RemoteApplyDataSource();

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      print('$id, $confusion');

      try {
        // 인스턴스 메서드를 호출하고 response를 받음
        final response = await remoteDataSource.setConfusionAlert(
          roomId: id,
          confusionLevel: confusion,
        );
        print('${response.Confusion}');

        if (response.Confusion == 0) {
          stopPolling(); // 혼잡도가 0이면 polling 중지
        }
      } catch (error) {
        print('Error occurred during polling: $error');
        stopPolling(); // 에러 발생 시 polling 중지
      }
    });
  }


  void stopPolling() {
    Home.count = 0;
    _timer?.cancel();
    isPollingActive = false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

