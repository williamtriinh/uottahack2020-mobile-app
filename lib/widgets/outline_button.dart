import "package:flutter/material.dart";

class OutlineButton extends StatelessWidget
{

  OutlineButton({@required this.label, @required this.onPressed});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.orangeAccent,
          width: 2.0,
        )
      ),
      fillColor: Colors.white,
      constraints: BoxConstraints(
        maxHeight: 34.0,
        minHeight: 34.0,
        maxWidth: double.infinity,
        minWidth: double.infinity
      ),
      child: Text(
        this.label,
      ),
      onPressed: this.onPressed,
    );
  }
}