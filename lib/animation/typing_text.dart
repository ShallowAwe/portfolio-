import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class TypingTextColumn extends StatefulWidget {
  final List<TextConfig> texts;
  final Duration typingSpeed;
  final Duration startDelay;
  final Duration delayBetweenTexts;
  final bool enableTypoEffect;

  const TypingTextColumn({
    super.key,
    required this.texts,
    this.typingSpeed = const Duration(milliseconds: 50),
    this.startDelay = const Duration(milliseconds: 500),
    this.delayBetweenTexts = const Duration(milliseconds: 500),
    this.enableTypoEffect = true,
  });

  @override
  State<TypingTextColumn> createState() => _TypingTextColumnState();
}

class TextConfig {
  final String text;
  final Color color;
  final String prefix;
  final String fontName;

  const TextConfig({
    required this.fontName,
    required this.text,
    this.color = Colors.white,
    this.prefix = '',
  });
}

class _TypingTextColumnState extends State<TypingTextColumn>
    with SingleTickerProviderStateMixin {
  List<String> displayTexts = [];
  int currentTextIndex = 0;
  int currentCharIndex = 0;
  bool showCursor = true;
  late AnimationController _cursorController;
  final math.Random _random = math.Random();

  // For typo effect
  bool isCorrectingTypo = false;
  String? typoText;

  @override
  void initState() {
    super.initState();
    displayTexts = List.filled(widget.texts.length, '');

    // Cursor Blink Animation
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _cursorController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showCursor = false);
        _cursorController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => showCursor = true);
        _cursorController.forward();
      }
    });

    _cursorController.forward();
    startTyping();
  }

  Duration _getRandomTypingDuration() {
    final baseSpeed = widget.typingSpeed.inMilliseconds;
    final variation = (baseSpeed * 0.5).toInt(); // 50% variation
    return Duration(
      milliseconds: baseSpeed + _random.nextInt(variation) - (variation ~/ 2),
    );
  }

  Future<void> _simulateTypo(String targetText) async {
    if (!widget.enableTypoEffect || _random.nextDouble() > 0.1)
      return; // 10% chance

    final typoLength = _random.nextInt(3) + 1; // 1-3 wrong characters
    final wrongChars = 'qwertyuiopasdfghjklzxcvbnm'.split('')..shuffle(_random);

    setState(() {
      typoText = targetText.substring(0, currentCharIndex) +
          wrongChars.take(typoLength).join();
      displayTexts[currentTextIndex] = typoText!;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    // Backspace effect
    for (int i = 0; i < typoLength; i++) {
      setState(() {
        typoText = typoText!.substring(0, typoText!.length - 1);
        displayTexts[currentTextIndex] = typoText!;
      });
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void startTyping() async {
    await Future.delayed(widget.startDelay);

    while (currentTextIndex < widget.texts.length) {
      final targetText = widget.texts[currentTextIndex].text;

      while (currentCharIndex < targetText.length) {
        if (!mounted) return;

        await _simulateTypo(targetText);

        setState(() {
          displayTexts[currentTextIndex] =
              targetText.substring(0, currentCharIndex + 1);
          currentCharIndex++;
        });

        await Future.delayed(_getRandomTypingDuration());
      }

      currentCharIndex = 0;
      currentTextIndex++;

      if (currentTextIndex < widget.texts.length) {
        await Future.delayed(widget.delayBetweenTexts);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < displayTexts.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.texts[i].prefix} ',
                  style: TextStyle(
                    color: widget.texts[i].color,
                    fontFamily: 'monospace',
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: displayTexts[i],
                          style: _getGoogleFont(widget.texts[i]),
                        ),
                        if (i == currentTextIndex)
                          TextSpan(
                            text: showCursor ? '|' : ' ',
                            style: TextStyle(
                              color: widget.texts[i].color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  TextStyle _getGoogleFont(TextConfig config) {
    try {
      return GoogleFonts.getFont(config.fontName,
          color: config.color, fontSize: 16);
    } catch (e) {
      print('⚠️ Font "${config.fontName}" not found. Using default font.');
      return GoogleFonts.roboto(color: config.color, fontSize: 16);
    }
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }
}
