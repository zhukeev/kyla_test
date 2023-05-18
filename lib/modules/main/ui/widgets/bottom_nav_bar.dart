import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          SizedBox(
            height: 80,
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
          ),
        ],
      ),
    );
  }

  Widget navigationBarItemIcons(IconData icon) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {},
      child: Icon(
        icon,
        color: const Color(0xFF8f8cf8),
        size: 36,
      ),
    );
  }
}
