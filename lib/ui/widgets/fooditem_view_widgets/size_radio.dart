import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';

class SizeRadio extends StatefulWidget {
  SizeRadio(
      {required this.value, required this.ind, required this.size, super.key});
  int value;
  int ind;
  String size;

  @override
  State<SizeRadio> createState() => _SizeRadioState();
}

class _SizeRadioState extends State<SizeRadio> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: (widget.value == widget.ind
              ? MyColors.primaryColor
              : MyColors.uiBlock),
          fixedSize: Size(100, 38)),
      onPressed: () {
        setState(() {
          widget.value = widget.ind;
        });
      },
      child: Text(
        widget.size,
        style: TextStyle(
          color: (widget.value == widget.ind)
              ? MyColors.buttonTextColor
              : MyColors.darkGray,
        ),
      ),
    );
  }
}
