import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        children: [
          MaterialButton(
            minWidth: 40,
            onPressed: () {},
            child: const Icon(
              Icons.folder_special,
              color: Color(0xFF8f8cf8),
              size: 36,
            ),
          ),
          MaterialButton(
            minWidth: 40,
            onPressed: () {},
            child: const Icon(
              Icons.search,
              color: Color(0xFF8f8cf8),
              size: 36,
            ),
          ),
          const Spacer(),
          MaterialButton(
            minWidth: 40,
            onPressed: () {},
            child: const Icon(
              Icons.bolt,
              color: Color(0xFF8f8cf8),
              size: 36,
            ),
          ),
          MaterialButton(
            minWidth: 40,
            onPressed: () {},
            child: const Icon(
              Icons.menu_outlined,
              color: Color(0xFF8f8cf8),
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
