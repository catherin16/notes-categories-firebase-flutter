import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
  final TextEditingController search;
  final Function() onPress;
  final Widget icon;
  final  Function(dynamic) onchange;
  const InputSearch({super.key,required this.search,required this.onPress,required this.icon,required this.onchange});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Container(
            height: 50,

            child: TextField(
              controller: search,
              decoration: InputDecoration(
                hintText: 'Buscar una Nota...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:  BorderSide(color: Colors.grey.withOpacity(0.4)),
                ),
                suffixIcon: IconButton(
                  icon: icon,
                  onPressed: onPress,

                ),
              ),
              onChanged: onchange
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
