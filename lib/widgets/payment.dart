import 'package:agrobeba/widgets/textWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class buildPaymentCardWidget extends StatefulWidget {
  const buildPaymentCardWidget({super.key});

  @override
  State<buildPaymentCardWidget> createState() => _buildPaymentCardWidgetState();
}

class _buildPaymentCardWidgetState extends State<buildPaymentCardWidget> {
  List<String> list = <String>[
    'Mpesa',
    'AllInOne',
    'Visa',
    'Airtel money',
    'Orange money'
  ];
  String dropdownValue = 'Mpesa';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/visa.png',
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(),
            onChanged: (String? value) {
              //This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: textWidget(text: value, color: Colors.black),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
