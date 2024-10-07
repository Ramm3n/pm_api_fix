import 'package:flutter_test/flutter_test.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';

void main() {
  group('API Service Tests', () {
    test('Test API request', () async {
      // Arrange
      final apiService = KependudukanCubit();
      final expectedResult = 'Expected result'; // Sesuaikan dengan harapan Anda

      // Act
      // apiService.sjp();
      // final result = context.read<KependudukanCubit>();

      // Assert
      expect(apiService, expectedResult);
    });
  });
}
