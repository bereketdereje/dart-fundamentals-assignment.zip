// Task 2: Async Calculator App - Version 2 (Class-Based Approach) - CORRECTED
// Name: ______________________
// Student ID: ________________

import 'dart:async';

// Named constant for operation delay - exactly 1500ms
const Duration operationDelay = Duration(milliseconds: 1500);

void main() async {
  print('=' * 60);
  print('           ASYNC CALCULATOR APP - VERSION 2');
  print('=' * 60);
  
  // Create operation queue
  OperationQueue queue = OperationQueue('BatchProcessor');
  
  // Add operations to queue
  queue.addOperation(CalculationRequest(10, 5, 'add'));
  queue.addOperation(CalculationRequest(10, 5, 'subtract'));
  queue.addOperation(CalculationRequest(10, 5, 'multiply'));
  queue.addOperation(CalculationRequest(10, 2, 'divide'));
  queue.addOperation(CalculationRequest(10, 0, 'divide')); // Error case
  queue.addOperation(CalculationRequest(15, 3, 'divide'));
  queue.addOperation(CalculationRequest(8, 2, 'power'));   // Error case
  
  // Process all operations
  await queue.processAll();
  
  // Display statistics
  queue.displayStatistics();
}

// Custom exception class
class UnknownOperationError implements Exception {
  final String operation;
  UnknownOperationError(this.operation);
  
  @override
  String toString() => 'Operation "$operation" is not supported';
}

// Represents a calculation request (immutable)
class CalculationRequest {
  final double a;
  final double b;
  final String operation;
  
  CalculationRequest(this.a, this.b, this.operation);
  
  @override
  String toString() => '$operation($a, $b)';
}

// Manages a queue of operations
class OperationQueue {
  final String queueName;
  final List<CalculationRequest> _pending = [];
  final List<String> _successLog = [];
  final List<String> _errorLog = [];
  final Stopwatch _timer = Stopwatch();
  
  OperationQueue(this.queueName);
  
  // Add operation to queue
  void addOperation(CalculationRequest request) {
    _pending.add(request);
    print('📋 Added to queue: $request');
  }
  
  // Synchronous arithmetic methods
  double _add(double a, double b) => a + b;
  double _subtract(double a, double b) => a - b;
  double _multiply(double a, double b) => a * b;
  
  double _divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('❌ Division by zero is not allowed');
    }
    return a / b;
  }
  
  // Execute a single operation - FIXED: Delay AFTER calculation
  Future<double> _executeOperation(CalculationRequest request) async {
    double result;
    
    // Perform calculation first (instant)
    switch (request.operation) {
      case 'add':
      case '+':
        result = _add(request.a, request.b);
        break;
      case 'subtract':
      case '-':
        result = _subtract(request.a, request.b);
        break;
      case 'multiply':
      case '*':
        result = _multiply(request.a, request.b);
        break;
      case 'divide':
      case '/':
        result = _divide(request.a, request.b);
        break;
      default:
        throw UnknownOperationError(request.operation);
    }
    
    // ✅ FIXED: Delay AFTER calculation - 1500ms
    await Future.delayed(operationDelay);  // 1500ms delay
    
    return result;
  }
  
  // Process a single operation with error handling
  Future<void> _processSingle(CalculationRequest request, int index) async {
    print('\n📌 [$index] Processing: $request');
    
    try {
      print('   ⏳ Calculating...');  // Show that calculation started
      double result = await _executeOperation(request);
      String logEntry = '$request = $result';
      _successLog.add(logEntry);
      print('   ✅ Result: $logEntry (after 1500ms delay)');
    } catch (e) {
      _errorLog.add(request.toString());
      print('   ❌ Failed: $e');
    }
  }
  
  // Process all operations in queue
  Future<void> processAll() async {
    print('\n⚙️  PROCESSING QUEUE: ${_pending.length} operations');
    print('-' * 40);
    
    _timer.start();
    
    for (int i = 0; i < _pending.length; i++) {
      await _processSingle(_pending[i], i + 1);
      // Each operation takes 1500ms due to delay in _executeOperation
    }
    
    _timer.stop();
    
    print('\n✅ Queue processing complete');
  }
  
  // Display statistics
  void displayStatistics() {
    print('\n' + '📊' * 15);
    print('         QUEUE STATISTICS');
    print('📊' * 15);
    print('Queue Name     : $queueName');
    print('Total Operations: ${_successLog.length + _errorLog.length}');
    print('Successful     : ${_successLog.length} ✓');
    print('Failed         : ${_errorLog.length} ✗');
    print('Processing Time: ${_timer.elapsedMilliseconds}ms');
    print('Expected Time  : ${_successLog.length * 1500}ms (1500ms per success)');
    
    if (_successLog.isNotEmpty) {
      print('\n✅ SUCCESSFUL OPERATIONS:');
      for (int i = 0; i < _successLog.length; i++) {
        print('   ${i + 1}. ${_successLog[i]}');
      }
    }
    
    if (_errorLog.isNotEmpty) {
      print('\n❌ FAILED OPERATIONS:');
      for (int i = 0; i < _errorLog.length; i++) {
        print('   ${i + 1}. ${_errorLog[i]}');
      }
    }
    
    // Demonstrate loop types
    print('\n🔄 LOOP DEMONSTRATION:');
    print('1. For loop with index (used above):');
    print('   for(int i=0; i<items.length; i++)');
    
    print('\n2. For-in loop:');
    if (_successLog.isNotEmpty) {
      for (String entry in _successLog.take(2)) {
        print('   • $entry');
      }
    }
  }
}