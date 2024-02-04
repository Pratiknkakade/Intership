import 'package:flutter/material.dart';
import 'package:pratik/TaskFirst/ImfoProvider.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.infoprovider,
  });

  final InfoProvider infoprovider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              // keyboardType: TextInputType.number,
              controller: infoprovider.namecontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'name',
              ),
            )),
        Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: infoprovider.registermobilecontroller,
              onChanged: infoprovider.validateMobileNumber,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'mobile',
                errorText: infoprovider.numberErrorText.isNotEmpty
                    ? infoprovider.numberErrorText
                    : null,
              ),
            )),
        Container(
          child: ElevatedButton(
            onPressed: () {
              infoprovider.registerNumberOnFirebase();
              infoprovider.showTextField = true;
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
