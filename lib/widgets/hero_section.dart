import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/animation/typing_text.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  double shadowOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Trigger shadow fade-in after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        shadowOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Left Text Section
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full-stack Developer & \nFront-End Enthusiast',
                style: GoogleFonts.caveatBrush(
                    color: Colors.black, fontSize: 55, letterSpacing: 2),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Hi, I'm Rudrankur Indurkar",
                  style: GoogleFonts.sriracha(
                      fontSize: 45,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "- a passionate full-stack developer",
                      style: GoogleFonts.eduSaBeginner(
                          fontSize: 25,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "- a B.E passout from BAMU",
                      style: GoogleFonts.eduSaBeginner(
                          fontSize: 25,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "- an avid reader",
                      style: GoogleFonts.eduSaBeginner(
                          fontSize: 25,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 100),

        // Animated Shadow + Static Container
        Stack(
          children: [
            // Shadow (Fades in)
            AnimatedOpacity(
              opacity: shadowOpacity,
              curve: Curves.easeInSine,
              duration: Duration(seconds: 2),
              child: Container(
                width: 450,
                height: 290,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[700]!.withAlpha(200),
                      offset: Offset(-20, -20),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
            // Terminal Container (Always Visible)
            Container(
              width: 450,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MacOS Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.circle, color: Colors.red, size: 12),
                      SizedBox(width: 6),
                      Icon(Icons.circle, color: Colors.yellow, size: 12),
                      SizedBox(width: 6),
                      Icon(Icons.circle, color: Colors.green, size: 12),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Terminal Text

                  TypingTextColumn(texts: [
                    TextConfig(
                      text: ' find / name -"life.dart"',
                      color: Colors.white,
                      prefix: '\$',
                      fontName: 'Roboto Mono',
                    ),
                    TextConfig(
                        text: '\$ Searching . . .',
                        color: Colors.green,
                        prefix: ' ',
                        fontName: 'Roboto Mono'),
                    TextConfig(
                        text: '> Error: something is found!',
                        color: Colors.red,
                        prefix: ' ',
                        fontName: 'Roboto Mono'),
                    TextConfig(
                      text: '> It\'s a bug...',
                      color: Colors.red,
                      prefix: ' ',
                      fontName: 'Roboto Mono',
                    ),
                    TextConfig(
                      text: '> IT\'S A BUG !!!',
                      color: Colors.red,
                      prefix: ' ',
                      fontName: 'Poppins',
                    ),
                    TextConfig(
                        text: '> Ah yes, programmer\'s life in one command !',
                        color: Colors.white,
                        prefix: ' ',
                        fontName: 'Coming Soon')
                  ])
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
