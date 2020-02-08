import "package:flutter/material.dart";

class ContainerButton extends StatelessWidget
{

  ContainerButton({@required this.label, @required this.onPressed});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.orangeAccent,
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