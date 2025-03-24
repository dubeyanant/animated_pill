import 'package:flutter/material.dart';

import 'package:animated_pill/animated_pill.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Pill Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Pill Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Usage',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AnimatedPill(
              'New Feature',
              backgroundColor: Colors.green,
              textColor: Colors.white,
            ),
            const SizedBox(height: 32),
            const Text(
              'Customized Appearance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AnimatedPill(
              'Limited Time Offer!',
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.0,
              borderRadius: 20.0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            const SizedBox(height: 32),
            const Text(
              'Customized Animation - 3 Loops',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AnimatedPill(
              'Flash Sale',
              animationLoops: 3,
              animationDuration: const Duration(milliseconds: 200),
              pauseDuration: const Duration(milliseconds: 1000),
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
            const SizedBox(height: 32),
            const Text(
              'No Animation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AnimatedPill(
              'Static Pill',
              animationLoops: 0,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
