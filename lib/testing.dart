import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final _formKey = GlobalKey<FormState>();
  final bool _autovalidate = false;
  String? selectedSalutation;
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: selectedSalutation,
              hint: const Text(
                'Salutation',
              ),
              onChanged: (salutation) =>
                  setState(() => selectedSalutation = salutation),
              validator: (value) => value == null ? 'field required' : null,
              items:
                  ['MR.', 'MS.'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Name is required' : null,
              onSaved: (value) => name = value,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                } else {
                  setState(() {
                    //enable realtime validation
                  });
                }
              },
              child: const Text("Prosess"),
            ),
          ],
        ),
      ),
    );
  }
}
