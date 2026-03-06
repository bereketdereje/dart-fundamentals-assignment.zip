

```markdown
# Dart Fundamentals Assignment 

**Name:** _Bereket Dereje_____________________
**Student ID:** ATE/8193/15________________

## 📋 Overview
this assignment implements both tasks using a **class-based approach** with clear separation of concerns.  demonstrates object-oriented design principles, encapsulation, and the Command Pattern.

## 📁 Files in This Version
```
dart-funndamentals-assignment/
├── task1/
│ └── number_analysis.dart
├── task2/
│ └── calculator_app.dart
├── reflection.md
└── README.md
```
---

## 🎯 Task 1: Number Analysis App (Class-Based)

### Key Features
- **NumberProcessor Class** with encapsulated data
- **AnalysisReport Class** for clean separation
- **Three Loop Styles** demonstrated:
  - For loop for maximum
  - For-in loop for minimum
  - Do-while loop for sum
- **Validation Layer** before processing
- **Private Fields** (`_data`) for encapsulation
- **Getter Methods** for controlled access

### Class Structure
```
NumberProcessor
├── Fields: _data, _lastReport
├── Methods: loadData(), processData()
├── Private: _validateData(), _findMaximum()
├── Private: _findMinimum(), _findTotal()
├── Private: _calculateAverage(), _demonstrateLoops()
└── Getter: report

AnalysisReport
├── Fields: data, max, min, sum, avg
├── Constructor: AnalysisReport()
└── Method: display()
```
---

### Sample Output
```
============================================================
NUMBER ANALYSIS APP - VERSION 2
============================================================
✅ Data loaded: 10 numbers

🔍 PROCESSING DATA

📊📊📊📊📊📊📊📊📊📊📊📊📊📊📊
ANALYSIS REPORT
📊📊📊📊📊📊📊📊📊📊📊📊📊📊📊
Data Set : [34, -7, 89, 12, -45, 67, 3, 100, -2, 55]

Maximum : 100
Minimum : -45
Sum : 306
Average : 30.60
Item Count : 10
📊📊📊📊📊📊📊📊📊📊📊📊📊📊📊
```
---

## 🧮 Task 2: Async Calculator App (Queue-Based with 1500ms Delay)

### Key Features
- **OperationQueue Class** managing task queue
- **CalculationRequest Class** (immutable)
- **Command Pattern** implementation
- **1500ms Delay AFTER Each Calculation** as required
- **Success/Error Logging** with statistics
- **Stopwatch Timing** for performance verification
- **Queue Processing** with sequential execution

### Delay Implementation
```dart
// Named constant for 1500ms delay
const Duration operationDelay = Duration(milliseconds: 1500);

// Delay happens AFTER calculation, before returning result
Future<double> _executeOperation(CalculationRequest request) async {
  double result = performCalculation(request);  // Instant
  await Future.delayed(operationDelay);         // 1500ms delay
  return result;                                 // Return after delay
}
```
Class Structure
```
OperationQueue
├── Fields: queueName, _pending, _successLog, _errorLog, _timer
├── Methods: addOperation(), processAll()
├── Private: _executeOperation(), _processSingle()
└── Method: displayStatistics()

CalculationRequest (immutable)
├── Fields: a, b, operation
└── Method: toString()

UnknownOperationError (custom exception)
└── Fields: operation
```
---
Sample Output with 1500ms Delays
---
```
============================================================
           ASYNC CALCULATOR APP - VERSION 2
============================================================
📋 Added to queue: add(10.0, 5.0)
📋 Added to queue: subtract(10.0, 5.0)
📋 Added to queue: multiply(10.0, 5.0)
📋 Added to queue: divide(10.0, 2.0)
📋 Added to queue: divide(10.0, 0.0)
📋 Added to queue: divide(15.0, 3.0)
📋 Added to queue: power(8.0, 2.0)

⚙️  PROCESSING QUEUE: 7 operations
----------------------------------------

📌 [1] Processing: add(10.0, 5.0)
   ⏳ Calculating...
   ✅ Result: add(10.0, 5.0) = 15.0 (after 1500ms delay)

📌 [2] Processing: subtract(10.0, 5.0)
   ⏳ Calculating...
   ✅ Result: subtract(10.0, 5.0) = 5.0 (after 1500ms delay)

📌 [3] Processing: multiply(10.0, 5.0)
   ⏳ Calculating...
   ✅ Result: multiply(10.0, 5.0) = 50.0 (after 1500ms delay)

📌 [4] Processing: divide(10.0, 2.0)
   ⏳ Calculating...
   ✅ Result: divide(10.0, 2.0) = 5.0 (after 1500ms delay)

📌 [5] Processing: divide(10.0, 0.0)
   ⏳ Calculating...
   ❌ Failed: ArgumentError: Division by zero is not allowed

📌 [6] Processing: divide(15.0, 3.0)
   ⏳ Calculating...
   ✅ Result: divide(15.0, 3.0) = 5.0 (after 1500ms delay)

📌 [7] Processing: power(8.0, 2.0)
   ⏳ Calculating...
   ❌ Failed: Operation "power" is not supported

✅ Queue processing complete

📊📊📊📊📊📊📊📊📊📊📊📊📊📊📊
         QUEUE STATISTICS
📊📊📊📊📊📊📊📊📊📊📊📊📊📊📊
Queue Name     : BatchProcessor
Total Operations: 7
Successful     : 5 ✓
Failed         : 2 ✗
Processing Time: 7500ms  (5 successes × 1500ms = 7500ms)
Expected Time  : 7500ms (1500ms per success)
```
---

Async Delay Implementation Details
All successful operations in Task 2 include a 1500ms delay AFTER calculation:

```dart
// The calculation happens instantly
double result = performCalculation(request);

// THEN we wait 1500ms to simulate real-world processing
await Future.delayed(operationDelay);  // Exactly 1500ms

// Result returned after delay
return result;
```
This means:

5 successful operations → 5 × 1500ms = 7500ms total processing time

Failed operations (divide by zero, unknown operation) → No delay (throw immediately)

Sequential execution → Each delay happens one after another

## 🚀 How to Run in DartPad

Open DartPad

Ensure "Dart" is selected

Copy the entire code from either file

Paste into DartPad editor

Click "Run" (▶) button

Note: The 1500ms delays are clearly observable when running - you'll see a pause between each successful operation result.