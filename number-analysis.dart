// Task 1: Number Analysis App - Version 2 (Class-Based Approach)
// Name: ______________________
// Student ID: ________________

void main() {
  print('=' * 60);
  print('           NUMBER ANALYSIS APP - VERSION 2');
  print('=' * 60);
  
  // Create processor with sample data
  NumberProcessor processor = NumberProcessor();
  processor.loadData([34, -7, 89, 12, -45, 67, 3, 100, -2, 55]);
  
  // Process and display results
  processor.processData();
  
  // Test empty list handling
  print('\n' + '🧪' * 20);
  print('         TESTING EMPTY LIST HANDLING');
  print('🧪' * 20);
  NumberProcessor emptyProcessor = NumberProcessor();
  emptyProcessor.processData();
}

// Main processor class
class NumberProcessor {
  // Private field with encapsulation
  List<int> _data = [];
  AnalysisReport? _lastReport;
  
  // Load data (creates a copy to preserve original)
  void loadData(List<int> newData) {
    _data = List.from(newData);
    print('✅ Data loaded: ${_data.length} numbers');
  }
  
  // Validate data before processing
  bool _validateData() {
    if (_data.isEmpty) {
      print('⚠️  Validation failed: No data to process');
      return false;
    }
    return true;
  }
  
  // Main processing method
  void processData() {
    print('\n🔍 PROCESSING DATA');
    print('-' * 40);
    
    if (!_validateData()) {
      print('Cannot generate report - please load data first');
      return;
    }
    
    // Perform analysis
    int maximum = _findMaximum();
    int minimum = _findMinimum();
    int total = _findTotal();
    double average = _calculateAverage();
    
    // Create and display report
    _lastReport = AnalysisReport(
      data: _data,
      max: maximum,
      min: minimum,
      sum: total,
      avg: average,
    );
    
    _lastReport!.display();
    _demonstrateLoops();
  }
  
  // Find maximum using for loop
  int _findMaximum() {
    int maxValue = _data[0];
    for (int i = 1; i < _data.length; i++) {
      if (_data[i] > maxValue) {
        maxValue = _data[i];
      }
    }
    return maxValue;
  }
  
  // Find minimum using for-in loop
  int _findMinimum() {
    int minValue = _data[0];
    for (int value in _data) {
      if (value < minValue) {
        minValue = value;
      }
    }
    return minValue;
  }
  
  // Find total using do-while loop
  int _findTotal() {
    int sum = 0;
    int index = 0;
    
    if (_data.isNotEmpty) {
      do {
        sum += _data[index];
        index++;
      } while (index < _data.length);
    }
    
    return sum;
  }
  
  // Calculate average by reusing _findTotal
  double _calculateAverage() {
    int total = _findTotal();
    return total / _data.length;
  }
  
  // Demonstrate different loop types
  void _demonstrateLoops() {
    print('\n🔄 LOOP TYPE DEMONSTRATION');
    print('-' * 40);
    
    print('1. FOR LOOP (with index):');
    StringBuffer sb1 = StringBuffer();
    for (int i = 0; i < _data.length && i < 4; i++) {
      sb1.write('${_data[i]} ');
    }
    print('   First 4: $sb1');
    
    print('\n2. FOR-IN LOOP (values only):');
    StringBuffer sb2 = StringBuffer();
    int count = 0;
    for (int val in _data) {
      if (count < 4) {
        sb2.write('$val ');
        count++;
      }
    }
    print('   First 4: $sb2');
    
    print('\n3. DO-WHILE LOOP (runs at least once):');
    StringBuffer sb3 = StringBuffer();
    int pos = 0;
    if (_data.isNotEmpty) {
      do {
        sb3.write('${_data[pos]} ');
        pos++;
      } while (pos < 4 && pos < _data.length);
    }
    print('   First 4: $sb3');
  }
  
  // Get report (for testing)
  AnalysisReport? get report => _lastReport;
}

// Separate report class for clean separation of concerns
class AnalysisReport {
  final List<int> data;
  final int max;
  final int min;
  final int sum;
  final double avg;
  
  AnalysisReport({
    required this.data,
    required this.max,
    required this.min,
    required this.sum,
    required this.avg,
  });
  
  void display() {
    print('\n' + '📊' * 15);
    print('         ANALYSIS REPORT');
    print('📊' * 15);
    print('Data Set     : $data');
    print('-' * 30);
    print('Maximum      : $max');
    print('Minimum      : $min');
    print('Sum          : $sum');
    print('Average      : ${avg.toStringAsFixed(2)}');
    print('Item Count   : ${data.length}');
    print('📊' * 15);
    
    // Verification
    print('\n🔍 Verification:');
    print('   Sum of all numbers: $sum');
    print('   Average calculation: $sum / ${data.length} = ${avg.toStringAsFixed(2)}');
  }
}