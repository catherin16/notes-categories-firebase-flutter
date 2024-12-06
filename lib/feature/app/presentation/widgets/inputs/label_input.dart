
import 'package:flutter/material.dart';


class LabelInput extends StatelessWidget {
  final String? label;

  const LabelInput({Key? key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 4, top: 6),
              child: Text(
                label!,
                style:
               const  TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}