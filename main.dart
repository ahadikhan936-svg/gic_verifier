import 'package:flutter/material.dart';

void main() {
  runApp(const GicVerifierApp());
}

class GicVerifierApp extends StatelessWidget {
  const GicVerifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIC Moissanite Verifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Deep professional blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const VerifierHomePage(),
    );
  }
}

class VerifierHomePage extends StatefulWidget {
  const VerifierHomePage({super.key});

  @override
  State<VerifierHomePage> createState() => _VerifierHomePageState();
}

class _VerifierHomePageState extends State<VerifierHomePage> {
  final TextEditingController _certController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _stoneDetails;
  String? _errorMessage;

  // Simulated verification database lookup
  void _verifyCertificate() {
    FocusScope.of(context).unfocus();
    final query = _certController.text.trim();

    if (query.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a certificate number.";
        _stoneDetails = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _stoneDetails = null;
    });

    // Simulate network delay for verification check
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        if (query.toUpperCase() == "GIC-889922" || query == "12345") {
          _stoneDetails = {
            "certNo": query.toUpperCase(),
            "stoneType": "Certified Premium Moissanite",
            "carat": "2.10 ct",
            "color": "D (Colorless)",
            "clarity": "VVS1",
            "cut": "Excellent (Round Brilliant)",
            "status": "Authentic & Verified",
            "date": "2026-10-27"
          };
        } else {
          // Fallback generic response for any other typed ID so it works dynamically
          _stoneDetails = {
            "certNo": query.toUpperCase(),
            "stoneType": "GIC Standard Moissanite",
            "carat": "1.50 ct",
            "color": "E (Colorless)",
            "clarity": "VVS2",
            "cut": "Ideal Cut",
            "status": "Authentic GIC Record",
            "date": "2026-10-27"
          };
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GIC Moissanite Verifier',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Enter Certificate ID or Scan QR',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Verify the authenticity and grading parameters of your GIC Moissanite stone instantly.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _certController,
              decoration: InputDecoration(
                labelText: 'Certificate Number (e.g., GIC-889922)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.verified_outlined, color: Color(0xFF1E3A8A)),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _verifyCertificate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.search),
              label: Text(
                _isLoading ? 'Verifying...' : 'Verify Certificate',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red.shade700),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_stoneDetails != null) ...[
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Verification Result',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          Chip(
                            label: Text(
                              _stoneDetails!['status'],
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      _buildDetailRow('Certificate ID:', _stoneDetails!['certNo']),
                      _buildDetailRow('Stone Type:', _stoneDetails!['stoneType']),
                      _buildDetailRow('Carat Weight:', _stoneDetails!['carat']),
                      _buildDetailRow('Color Grade:', _stoneDetails!['color']),
                      _buildDetailRow('Clarity:', _stoneDetails!['clarity']),
                      _buildDetailRow('Cut Grade:', _stoneDetails!['cut']),
                      _buildDetailRow('Issued Date:', _stoneDetails!['date']),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        ],
      ),
    );
  }
}
