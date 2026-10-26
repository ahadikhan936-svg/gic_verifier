import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const GicApp());
}

class GicApp extends StatelessWidget {
  const GicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIC MOISSANITE VERIFIER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4AF37),
          primary: const Color(0xFFD4AF37),
          secondary: const Color(0xFFC5A028),
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const VerifierScreen(),
    );
  }
}

class VerifierScreen extends StatefulWidget {
  const VerifierScreen({super.key});

  @override
  State<VerifierScreen> createState() => _VerifierScreenState();
}

class _VerifierScreenState extends State<VerifierScreen> {
  final TextEditingController _controller = TextEditingController();
  VerificationResult? _result;

  void _verifyNumber() {
    FocusScope.of(context).unfocus();
    final input = _controller.text.trim();

    if (input.isEmpty) {
      setState(() {
        _result = null;
      });
      return;
    }

    final parsedNumber = int.tryParse(input);

    if (parsedNumber == null) {
      setState(() {
        _result = VerificationResult(
          isCertified: false,
          regNumber: input,
          message: 'Not Certified By Us',
        );
      });
      return;
    }

    // Range 1: 076523 to 077523 -> 3ct
    if (parsedNumber >= 76523 && parsedNumber <= 77523) {
      setState(() {
        _result = VerificationResult(
          isCertified: true,
          regNumber: input,
          caratWeight: '3ct',
          message: 'Your Moissanite is Certified and It\'s of 3ct.',
        );
      });
    }
    // Range 2: 077623 to 078623 -> 4ct
    else if (parsedNumber >= 77623 && parsedNumber <= 78623) {
      setState(() {
        _result = VerificationResult(
          isCertified: true,
          regNumber: input,
          caratWeight: '4ct',
          message: 'Your Moissanite is Certified and It\'s of 4ct.',
        );
      });
    }
    // Otherwise -> Not Certified By Us
    else {
      setState(() {
        _result = VerificationResult(
          isCertified: false,
          regNumber: input,
          message: 'Not Certified By Us',
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // Centralized Gold Header Box
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF9E6), Color(0xFFFFF2C2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    Icon(
                      Icons.diamond_outlined,
                      size: 44,
                      color: Color(0xFFB38F1D),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'GIC MOISSANITE VERIFIER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Color(0xFF8A6D0F),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Search Input Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5D7A3), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _verifyNumber(),
                  decoration: const InputDecoration(
                    hintText: 'Enter Your Moissanite Registration Number',
                    hintStyle: TextStyle(
                      color: Color(0xFFA69B7C),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Verify Button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _verifyNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // Result Display Card
              if (_result != null) ...[
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(_result!.regNumber),
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _result!.isCertified
                            ? const Color(0xFFD4AF37)
                            : const Color(0xFFE57373),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_result!.isCertified
                                  ? const Color(0xFFD4AF37)
                                  : const Color(0xFFE57373))
                              .withOpacity(0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _result!.isCertified
                              ? Icons.verified
                              : Icons.cancel_outlined,
                          size: 54,
                          color: _result!.isCertified
                              ? const Color(0xFFD4AF37)
                              : const Color(0xFFE57373),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          _result!.isCertified
                              ? 'CERTIFIED AUTHENTIC'
                              : 'NOT CERTIFIED',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            color: _result!.isCertified
                                ? const Color(0xFF8A6D0F)
                                : const Color(0xFFC62828),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _result!.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                            height: 1.4,
                          ),
                        ),
                        if (_result!.isCertified &&
                            _result!.caratWeight != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9E6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withOpacity(0.5),
                              ),
                            ),
                            child: Text(
                              'Weight: ${_result!.caratWeight}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8A6D0F),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationResult {
  final bool isCertified;
  final String regNumber;
  final String? caratWeight;
  final String message;

  VerificationResult({
    required this.isCertified,
    required this.regNumber,
    this.caratWeight,
    required this.message,
  });
}
