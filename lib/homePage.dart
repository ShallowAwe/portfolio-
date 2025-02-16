import 'package:flutter/material.dart';
import 'package:portfolio/widgets/custom_app_bar.dart';
import 'package:portfolio/widgets/hero_section.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Slightly longer initial delay for smoother transition
    Future.delayed(const Duration(milliseconds: 450), () {
      if (mounted) {
        setState(() {
          _isLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using Container as the background instead of Scaffold's background
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Color.fromARGB(230, 244, 244, 239),
              Color.fromARGB(200, 219, 219, 206),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            opacity: _isLoaded ? 1.0 : 0.0,
            child: Column(
              children: [
                const CustomAppBar(),
                const SizedBox(height: 100),
                // Hero section without additional FutureBuilder
                const HeroSection(),
                // Add more sections here as needed
                const SizedBox(height: 100), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
