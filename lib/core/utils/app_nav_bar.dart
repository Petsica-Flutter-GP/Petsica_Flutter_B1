import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20.0), // المسافة من الجانبين
      child: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: kBurgColor,
        unselectedItemColor: kInputWordColor,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.people,
                  size: currentIndex == 0 ? 35 : 30,
                  color: currentIndex == 0 ? kBurgColor : kInputWordColor,
                ),
                const SizedBox(height: 4),
                Text(
                  "Community",
                  style: TextStyle(
                    fontSize: currentIndex == 0 ? 16 : 14,
                    color: currentIndex == 0 ? kBurgColor : kInputWordColor,
                  ),
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: currentIndex == 1 ? 35 : 30,
                  color: currentIndex == 1 ? kBurgColor : kInputWordColor,
                ),
                const SizedBox(height: 4),
                Text(
                  "Store",
                  style: TextStyle(
                    fontSize: currentIndex == 1 ? 16 : 14,
                    color: currentIndex == 1 ? kBurgColor : kInputWordColor,
                  ),
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.pets,
                  size: currentIndex == 2 ? 35 : 30,
                  color: currentIndex == 2 ? kBurgColor : kInputWordColor,
                ),
                const SizedBox(height: 4),
                Text(
                  "Service",
                  style: TextStyle(
                    fontSize: currentIndex == 2 ? 16 : 14,
                    color: currentIndex == 2 ? kBurgColor : kInputWordColor,
                  ),
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_hospital,
                  size: currentIndex == 3 ? 35 : 30,
                  color: currentIndex == 3 ? kBurgColor : kInputWordColor,
                ),
                const SizedBox(height: 4),
                Text(
                  "Clinic",
                  style: TextStyle(
                    fontSize: currentIndex == 3 ? 16 : 14,
                    color: currentIndex == 3 ? kBurgColor : kInputWordColor,
                  ),
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: currentIndex == 4 ? 35 : 30,
                  color: currentIndex == 4 ? kBurgColor : kInputWordColor,
                ),
                const SizedBox(height: 4),
                Text(
                  "Alarm",
                  style: TextStyle(
                    fontSize: currentIndex == 4 ? 16 : 14,
                    color: currentIndex == 4 ? kBurgColor : kInputWordColor,
                  ),
                ),
              ],
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
