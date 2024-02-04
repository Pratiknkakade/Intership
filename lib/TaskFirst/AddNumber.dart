import 'package:flutter/material.dart';
import 'package:pratik/TaskFirst/ImfoProvider.dart';

class AddNumber extends StatelessWidget {
  const AddNumber({
    super.key,
    required this.infoprovider,
  });

  final InfoProvider infoprovider;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: infoprovider.numbercontroller,
      onChanged: (value) {
        infoprovider.val = value;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'number',
      ),
    );
  }
}
