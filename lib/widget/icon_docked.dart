
import 'package:flutter/material.dart';

class IconDocked extends StatefulWidget {
  final PageController pageController;
  final bool isSelected;
  final IconData icon;
  final String name;
  final int index;

  const IconDocked(
      {super.key,
      required this.pageController,
      required this.isSelected,
      required this.icon,
      required this.name,
      required this.index});

  @override
  State<IconDocked> createState() => _IconDockedState();
}

class _IconDockedState extends State<IconDocked> {
  late PageController pageController;
  late bool isSelected;
  late IconData icon;
  late String name;
  late int index;

  @override
  void initState() {
    pageController = widget.pageController;
    isSelected = widget.isSelected;
    icon = widget.icon;
    name = widget.name;
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 4)),
        IconButton(
            icon: isSelected
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  )
                : Icon(
                    icon,
                    color: Colors.lightBlueAccent,
                    size: 22,
                  ),
            onPressed: () => {pageController.jumpToPage(index)}),
        isSelected
            ? Text(name, style: const TextStyle(color: Colors.white, fontSize: 10))
            : Text(name,
                style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 10))
      ],
    );
  }
}
