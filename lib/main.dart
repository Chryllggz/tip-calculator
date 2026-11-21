import 'package:flutter/material.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) => double.tryParse(input.trim());

({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController billController = TextEditingController();

  int selectedPercent = 15;

  @override
  void dispose() {
    billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(billController.text);

    final validBill = bill != null && bill.isFinite && bill >= 0;

    final result = validBill ? computeTip(bill, selectedPercent) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Tip Calculator'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Bill Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: billController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Bill Amount',
                prefixText: '₱ ',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(height: 25),

            const Text(
              'Select Tip Percentage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            SegmentedButton<int>(
              segments: const [
                ButtonSegment<int>(value: 10, label: Text('10%')),
                ButtonSegment<int>(value: 15, label: Text('15%')),
                ButtonSegment<int>(value: 20, label: Text('20%')),
              ],
              selected: {selectedPercent},
              onSelectionChanged: (value) {
                setState(() {
                  selectedPercent = value.first;
                });
              },
            ),

            const SizedBox(height: 30),

            if (validBill) ...[
              Text(
                'Tip: ₱${result!.tip.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 15),

              Text(
                'Total: ₱${result.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else ...[
              const Text(
                'Enter a valid amount',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
