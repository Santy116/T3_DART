import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorBMI());
}

class CalculatorBMI extends StatelessWidget {
  const CalculatorBMI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator BMI',
      home: BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _berat = TextEditingController();
  final _tinggi = TextEditingController();
  String _jenisKelamin = 'Laki-laki';

  double? _hasil;
  String? _kategori;

  void _hitungMBI() {
    final double weight = double.tryParse(_berat.text) ?? 0;
    final double height = double.tryParse(_tinggi.text) ?? 0;

    setState(() {
      if (weight > 0 && height > 0) {
        final double heightInM = height / 100;
        final bmi = weight / (heightInM * heightInM);
        _hasil = bmi;
        
        if (_jenisKelamin == 'Laki-laki') {
          if (bmi < 18.5) {
            _kategori = "Kurus";
          } else if (bmi < 25) {
            _kategori = 'Ideal';
          } else if (bmi < 30) {
            _kategori = "Gemuk";
          } else {
            _kategori = "Obesitas";
          }
        } else {
          if (bmi < 17) {
            _kategori = "Kurus";
          } else if (bmi < 23) {
            _kategori = 'Ideal';
          } else if (bmi < 30) {
            _kategori = "Gemuk";
          } else {
            _kategori = "Obesitas";
          }
        }
      } else {
        _hasil = null;
        _kategori = 'Masukan data yang valid';
      }
    });
  }

  void _resetData() {
    setState(() {
      _berat.clear();
      _tinggi.clear();
      _hasil = null;
      _kategori = null;
      _jenisKelamin = 'Laki-laki';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator BMI'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenis Kelamin',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text('Laki-laki'),
                            value: 'Laki-laki',
                            groupValue: _jenisKelamin,
                            onChanged: (value) {
                              setState(() {
                                _jenisKelamin = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text('Perempuan'),
                            value: 'Perempuan',
                            groupValue: _jenisKelamin,
                            onChanged: (value) {
                              setState(() {
                                _jenisKelamin = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Input Berat Badan
            TextField(
              controller: _berat,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat Badan (Kg)',
                icon: Icon(Icons.monitor_weight),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
          
            TextField(
              controller: _tinggi,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tinggi Badan (cm)',
                icon: Icon(Icons.height),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            
            // Tombol Hitung dan Reset
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hitungMBI,
                    child: Text('Hitung BMI'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: Text('Reset'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // Hasil
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Hasil BMI',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _hasil?.toStringAsFixed(1) ?? '--',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _kategori?.toUpperCase() ?? 'MASUKKAN DATA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Jenis Kelamin: $_jenisKelamin',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}