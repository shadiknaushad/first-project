// ignore_for_file: avoid_types_as_parameter_names
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const BMIcalculatorApp());
}

class BMIcalculatorApp extends StatelessWidget {
  const BMIcalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController heightcontroller = TextEditingController();
  final TextEditingController weightcontroller = TextEditingController();

  double? bmi;
  String category = "";
  String gender = "Male";

  get weight => null;

  void calculateBMI() {
    double height = double.parse(heightcontroller.text) / 100;
    double Weight = double.parse(weightcontroller.text);

    setState(() {
      bmi = Weight / pow(height, 2); // standard BMI formula

      if (bmi! < 18.5) {
        category = "Underweight";
      } else if (bmi! >= 18.5 && bmi! <= 24.9) {
        category = "Normal";
      } else if (bmi! >= 25 && bmi! < 29.9) {
        category = "Overweight";
      } else {
        category = "sameer";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 105, 13, 170),
              Color.fromARGB(255, 164, 106, 187),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your Detaials',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildGenderToggle(),

            const SizedBox(height: 20),
            _buildInputFields(
              controller: heightcontroller,
              label: "Height (cm)",
              icon: Icons.fitness_center,
            ),

            const SizedBox(height: 20),
            _buildInputFields(
              controller: weightcontroller,
              label: "Weight (kg)",
              icon: Icons.fitness_center,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xff8e44ad),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
              ),

              child: const Text(
                "calculate BMI",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (bmi != null) _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButtom("Male", Icons.male, gender == "Male"),
        const SizedBox(width: 20),
        _buildGenderButtom("Female", Icons.female, gender == "Female"),
      ],
    );
  }

  Widget _buildGenderButtom(String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset.fromDirection(0.3),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.deepPurple : Colors.white),
            const SizedBox(width: 10),

            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.deepPurple : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purpleAccent),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      // ignore: deprecated_member_use
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "your BMI: ${bmi!.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              "Category :$category",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: bmi! < 18.5
                    ? Colors.orange
                    : (bmi! < 24.9
                          ? Colors.green
                          : (bmi! < 29.9 ? Colors.orange : Colors.red)),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              "Gender: $gender",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
