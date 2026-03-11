import 'package:zanadu/features/health_coach/data/model/answer_model.dart';

class BMIUtils {
  static double calculateBMI(double weightKg, double heightCm) {
    if (weightKg <= 0 || heightCm <= 0) {
      return 0.0;
    }
    
    // Convert height from cm to meters
    double heightM = heightCm / 100.0;
    
    // BMI formula: weight (kg) / (height (m))^2
    return weightKg / (heightM * heightM);
  }
  
  static String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
  
  static String formatBMI(double bmi) {
    if (bmi == 0.0) {
      return 'N/A';
    }
    return bmi.toStringAsFixed(1);
  }
  
  // Helper method to extract numeric value from answer string
  static double? extractNumericValue(String answer) {
    try {
      // Remove any non-numeric characters except decimal point
      String cleanValue = answer.replaceAll(RegExp(r'[^0-9.]'), '');
      if (cleanValue.isEmpty) return null;
      return double.parse(cleanValue);
    } catch (e) {
      return null;
    }
  }
  
  // Find weight, height, and age answers from the list of answers
  static Map<String, double?> findHealthMetrics(List<dynamic> answers) {
    double? weight;
    double? height;
    double? age;
    
    for (var answer in answers) {
      String questionName = '';
      List<String> answerList = [];
      
      if (answer is Answer) {
        questionName = answer.questionName.toLowerCase();
        answerList = answer.answer;
      } else if (answer is Map<String, dynamic>) {
        questionName = answer['questionName']?.toString().toLowerCase() ?? '';
        answerList = List<String>.from(answer['answer'] ?? []);
      }
      
      if (answerList.isNotEmpty) {
        String answerValue = answerList.first;
        double? numericValue = extractNumericValue(answerValue);
        
        if (numericValue != null) {
          if (questionName.contains('weight') || questionName.contains('kg')) {
            weight = numericValue;
          } else if (questionName.contains('height') || questionName.contains('cm') || questionName.contains('tall')) {
            height = numericValue;
          } else if (questionName.contains('age') || questionName.contains('years') || questionName.contains('old')) {
            age = numericValue;
          }
        }
      }
    }
    
    return {
      'weight': weight,
      'height': height,
      'age': age,
    };
  }
}
