

import 'package:flutter/material.dart';

import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/styles.dart';

import '../../../constant/sizedbox.dart';

class FilledButton extends StatefulWidget {
  FilledButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      double? borderRadius,
      Color? buttonColor,
      Color? hoverColor,
      Color? textColor,
      bool? isActive,
      Size? buttonSize,})
      : super(key: key) {
    if (borderRadius != null) {
      border_Radius = borderRadius;
    }

    if (buttonColor != null) {
      button_Color = buttonColor;
    }

    if (buttonSize != null) {
      button_Size = buttonSize;
    }
    if (buttonSize != null) {
      button_Size = buttonSize;
    }
    if (isActive != null) {
      is_Active = isActive;
    }
  }
  String buttonText;
  final Function onPressed;
  double border_Radius = 8;
  Color button_Color = MyColors.primaryColor;
  Size button_Size = Size(0,0) ;
  bool is_Active=true;

  @override
  State<FilledButton> createState() => _FilledButtonState();
}

class _FilledButtonState extends State<FilledButton> {
  @override
  Widget build(BuildContext context) {
    widget.button_Size = (widget.button_Size==Size(0,0)) ?Size(MediaQuery.of(context).size.width * 0.99, 60): widget.button_Size;

    return TextButton(
      onPressed: widget.is_Active ? () { widget.onPressed(); }   : () {},
      style: ElevatedButton.styleFrom(
        primary: widget.is_Active ? widget.button_Color : MyColors.lightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.border_Radius),
          ),
        ),
        minimumSize: widget.button_Size,
      ),
      child: Text(
        widget.buttonText,
        style: Styles.buttonText,
      ),
    );
  }
}

class IconButton extends StatefulWidget {
  IconButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.icon,
    double? borderRadius,
    Color? buttonColor,
    Color? iconColor,
    Size? buttonSize,
    double? iconSize,
    bool? isActive
  }) : super(key: key) {
    if (borderRadius != null) {
      border_Radius = borderRadius;
    }

    if (buttonColor != null) {
      button_Color = buttonColor;
    }
    if (iconColor != null) {
      icon_Color = iconColor;
    }

    if (buttonSize != null) {
      button_Size = buttonSize;
    }

    if (iconSize != null) {
      icon_Size = iconSize;
    }
    if (isActive != null) {
      is_Active = isActive;
    }
  }
  String buttonText;
  final Function onPressed;
  double border_Radius = 8;
  Color button_Color = MyColors.primaryColor;
  bool is_Active=true;

  Color icon_Color = MyColors.white;
  Size button_Size = const Size(350, 50);
  IconData icon;

  double icon_Size = 20;

  @override
  State<IconButton> createState() => _IconButtonState();
}

class _IconButtonState extends State<IconButton> {
  @override
  Widget build(BuildContext context) {
    widget.button_Size = (widget.button_Size==Size(0,0)) ?Size(MediaQuery.of(context).size.width * 0.99, 60): widget.button_Size;
    return TextButton(
      onPressed: widget.is_Active ? () { widget.onPressed(); }   : () {},
      style: ElevatedButton.styleFrom(
          primary: widget.is_Active ? widget.button_Color : MyColors.lightGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.border_Radius),
            ),
          ),
          minimumSize: widget.button_Size,
          maximumSize: widget.button_Size),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, color: widget.icon_Color, size: widget.icon_Size),
          SizedBoxes.horizontalHigherMicro,
          Text(
            widget.buttonText,
            style: Styles.buttonText,
          ),
        ],
      ),
    );
  }
}

class SecondaryFilledButton extends StatefulWidget {
  SecondaryFilledButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      double? borderRadius,
      Color? buttonColor,
      Color? textColor,
      bool? isActive,
      Size? buttonSize})
      : super(key: key) {
    if (borderRadius != null) {
      border_Radius = borderRadius;
    }

    if (buttonColor != null) {
      button_Color = buttonColor;
    }

    if (buttonSize != null) {
      button_Size = buttonSize;
    }
    if (buttonSize != null) {
      button_Size = buttonSize;
    }
    if (isActive != null) {
      is_Active = isActive;
    }
  }
  String buttonText;
  final Function onPressed;
  double border_Radius = 8;
  Color button_Color = MyColors.primaryColor;
  Size button_Size = const Size(600, 60);
  bool is_Active=true;

  @override
  State<SecondaryFilledButton> createState() => _SecondaryFilledButtonState();
}

class _SecondaryFilledButtonState extends State<SecondaryFilledButton> {
  @override
  Widget build(BuildContext context) {
    widget.button_Size = (widget.button_Size==Size(0,0)) ?Size(MediaQuery.of(context).size.width * 0.99, 60): widget.button_Size;
    return TextButton(
      onPressed: widget.is_Active ? () { widget.onPressed(); }   : () {},
      style: ElevatedButton.styleFrom(
        primary: widget.is_Active ? widget.button_Color : MyColors.lightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.border_Radius),
          ),
        ),
        minimumSize: widget.button_Size,
      ),
      child: Text(
        widget.buttonText,
        style: Styles.buttonTextDark,
      ),
    );
  }
}
