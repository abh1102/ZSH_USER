import 'package:flutter_test/flutter_test.dart';
import 'package:zanadu/utils/bmi_utils.dart';

void main() {
  group('BMI Utils Tests', () {
    test('calculateBMI should return correct BMI value', () {
      // Test with known values: 70kg weight, 175cm height
      // Expected BMI: 70 / (1.75 * 1.75) = 22.86
      double result = BMIUtils.calculateBMI(70, 175);
      expect(result, closeTo(22.86, 0.01));
    });

    test('calculateBMI should return 0 for invalid inputs', () {
      expect(BMIUtils.calculateBMI(0, 175), 0.0);
      expect(BMIUtils.calculateBMI(70, 0), 0.0);
      expect(BMIUtils.calculateBMI(-10, 175), 0.0);
    });

    test('getBMICategory should return correct categories', () {
      expect(BMIUtils.getBMICategory(16.5), 'Underweight');
      expect(BMIUtils.getBMICategory(22.0), 'Normal weight');
      expect(BMIUtils.getBMICategory(27.0), 'Overweight');
      expect(BMIUtils.getBMICategory(32.0), 'Obese');
    });

    test('formatBMI should format correctly', () {
      expect(BMIUtils.formatBMI(22.857), '22.9');
      expect(BMIUtils.formatBMI(0.0), 'N/A');
    });

    test('extractNumericValue should extract numbers from strings', () {
      expect(BMIUtils.extractNumericValue('70 kg'), 70.0);
      expect(BMIUtils.extractNumericValue('175 cm'), 175.0);
      expect(BMIUtils.extractNumericValue('25 years'), 25.0);
      expect(BMIUtils.extractNumericValue('invalid'), null);
    });

    test('findHealthMetrics should extract weight, height, and age', () {
      List<Map<String, dynamic>> answers = [
        {
          'questionName': 'What is your weight in kg?',
          'answer': ['70 kg']
        },
        {
          'questionName': 'What is your height in cm?',
          'answer': ['175 cm']
        },
        {
          'questionName': 'What is your age?',
          'answer': ['25 years']
        },
        {
          'questionName': 'Other question',
          'answer': ['some answer']
        }
      ];

      var metrics = BMIUtils.findHealthMetrics(answers);
      expect(metrics['weight'], 70.0);
      expect(metrics['height'], 175.0);
      expect(metrics['age'], 25.0);
    });
  });
}
