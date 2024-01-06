import 'package:flutter/material.dart';

class CustomButtonCreateOrder extends StatefulWidget {
  VoidCallback onClick;
  String title;
  Color bgColor;
  Color borderColor;
  TextStyle textStyle;

  CustomButtonCreateOrder(
      {required this.onClick,
      required this.title,
      required this.bgColor,
      required this.borderColor,
      required this.textStyle});

  @override
  State<StatefulWidget> createState() => _CustomButtonBuyNow();
}

class _CustomButtonBuyNow extends State<CustomButtonCreateOrder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 24,
      child: ElevatedButton(
        onPressed: widget.onClick,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(
              color: widget.borderColor,
              width: 1,
            ),
            shadowColor: Colors.transparent,
            primary: widget.bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: Text(
          widget.title,
          textScaleFactor: 1.0,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
