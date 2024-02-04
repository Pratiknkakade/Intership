import 'package:flutter/material.dart';
import 'package:pratik/TaskFirst/ImfoProvider.dart';
import 'package:pratik/TaskFirst/RegisterNumber.dart';
import 'package:pratik/TaskFirst/ViewPage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final infoprovider = Provider.of<InfoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(' login page')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: infoprovider.showTextField
                  ? TextField(
                      keyboardType: TextInputType.number,
                      controller: infoprovider.mobilecontroller,
                      onChanged: infoprovider.validateMobileNumber,
                      decoration: InputDecoration(
                        prefixText: '+91',
                        border: const OutlineInputBorder(),
                        labelText: 'mobile number',
                        errorText: infoprovider.numberErrorText.isNotEmpty
                            ? infoprovider.numberErrorText
                            : null,
                      ),
                    )
                  : TextFieldWidget(infoprovider: infoprovider),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (infoprovider.registerError.isNotEmpty) {
                infoprovider.changefalse();
                infoprovider.mobilecontroller.text = '';
              } else {
                //infoprovider.login = true;
                infoprovider.registerError = '-';
                infoprovider.saveLoginInfo(
                    int.parse(infoprovider.mobilecontroller.text), true);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewPage()),
                );
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
