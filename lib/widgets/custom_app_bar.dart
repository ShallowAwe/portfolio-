import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<String> menuItems = ["Home", "About", "Projects", "Contact"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'portfolio',
            style: GoogleFonts.notoSans(
              fontSize: 20,
              wordSpacing: 0.6,
              color: Colors.black,
            ),
          ),
          Row(
            children: menuItems.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith(
                      (states) {
                        if (states.contains(WidgetState.hovered)) {
                          return Colors.black.withAlpha(50);
                        } else if (states.contains(WidgetState.pressed)) {
                          return Colors.black.withAlpha(77);
                        }
                        return null;
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    item,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
