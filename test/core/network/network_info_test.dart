import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/core/network/network_info.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity connectivity;
  late ConnectivityNetworkInfo networkInfo;

  setUp(() {
    connectivity = MockConnectivity();
    networkInfo = ConnectivityNetworkInfo(connectivity);
  });

  group('ConnectivityNetworkInfo', () {
    test(
      'isOnline returns true when at least one result is not none',
      () async {
        when(() => connectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.wifi]);
        expect(await networkInfo.isOnline, isTrue);
      },
    );

    test('isOnline returns false when only none is present', () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      expect(await networkInfo.isOnline, isFalse);
    });

    test('onOnlineChanged emits true then false on connectivity changes', () {
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream.fromIterable([
          [ConnectivityResult.mobile],
          [ConnectivityResult.none],
        ]),
      );

      expectLater(networkInfo.onOnlineChanged, emitsInOrder([isTrue, isFalse]));
    });
  });
}
