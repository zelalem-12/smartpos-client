import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smartpos_client/features/activation/data/datasources/activation_local_source.dart';
import 'package:smartpos_client/features/activation/data/datasources/activation_remote_source.dart';
import 'package:smartpos_client/features/activation/data/models/activation_response_model.dart';
import 'package:smartpos_client/features/activation/data/repositories/activation_repository_impl.dart';
import 'package:smartpos_client/features/activation/domain/entities/store_config_entity.dart';

class MockActivationRemoteSource extends Mock
    implements ActivationRemoteSource {}

class MockActivationLocalSource extends Mock
    implements ActivationLocalSource {}

void main() {
  late ActivationRepositoryImpl repository;
  late MockActivationRemoteSource mockRemote;
  late MockActivationLocalSource mockLocal;

  const responseModel = ActivationResponseModel(
    businessName: 'Bole Roasters Cafe PLC',
    tradeName: 'Bole Cafe',
    tin: '0012345678',
    vatRegNo: '123456789',
    sector: '18. Restaurants & Food Service',
    address: 'Addis Ababa, Bole',
    deviceSerial: 'SUNMI-V2P-ET-89412',
  );

  setUp(() {
    mockRemote = MockActivationRemoteSource();
    mockLocal = MockActivationLocalSource();
    repository = ActivationRepositoryImpl(
      remoteSource: mockRemote,
      localSource: mockLocal,
    );
  });

  setUpAll(() {
    registerFallbackValue(const StoreConfigEntity(
      licenseKey: '',
      businessName: '',
      tradeName: '',
      tin: '',
      vatRegNo: '',
      sector: '',
      address: '',
      deviceSerial: '',
    ));
  });

  group('ActivationRepositoryImpl', () {
    test('calls remote source then saves locally and returns entity', () async {
      when(() => mockRemote.activateDevice('ACT-89412'))
          .thenAnswer((_) async => responseModel);
      when(() => mockLocal.saveStoreConfig(any()))
          .thenAnswer((_) async {});

      final result = await repository.activateDevice('ACT-89412');

      expect(result.licenseKey, 'ACT-89412');
      expect(result.tin, '0012345678');
      expect(result.businessName, 'Bole Roasters Cafe PLC');

      verify(() => mockRemote.activateDevice('ACT-89412')).called(1);
      verify(() => mockLocal.saveStoreConfig(any())).called(1);
    });

    test('does not save locally if remote fails', () async {
      when(() => mockRemote.activateDevice('ACT-99999'))
          .thenThrow(Exception('Network error'));

      expect(
        () => repository.activateDevice('ACT-99999'),
        throwsA(isA<Exception>()),
      );

      verifyNever(() => mockLocal.saveStoreConfig(any()));
    });
  });
}
