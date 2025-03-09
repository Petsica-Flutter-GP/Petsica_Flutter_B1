import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/styles.dart';

class CategoryDrawer extends StatelessWidget {
  const CategoryDrawer({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<String> categories; 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: kAppColor),
            child: Row(
              children: [
                const Icon(
                  Icons.segment_rounded,
                  size: 35,
                ),
                const SizedBox(width: 10),
                Text("Categories", style: Styles.textStyleCom26),
              ],
            ),
          ),
          ...categories.map((category) => ListTile(title: Text(category))),
        ],
      ),
    );
  }
}
