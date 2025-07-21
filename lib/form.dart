import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  //form extends from a stateful widget
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState(); // createState method returns an instance of the state class
}

class _FormPageState extends State<FormPage> {
  // _FormPageState is the state class for FormPage
  // This class holds the state of the form, including the form key and the fields' values.
  // The underscore before the class name indicates that this class is private to this file.

  final _formKey =
      GlobalKey<
        FormState
      >(); // GlobalKey is used to uniquely identify the Form widget and its state.
  // This key allows us to access the form's state for validation and saving.

  String _name = '';
  String _email = '';
  // ignore: unused_field
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text('Name: $_name, Email: $_email'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _name = '';
      _email = '';
      _password = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Widget Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            // ignore: avoid_print
            print("Form changed");
          },
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter your email';
                  if (!value.contains('@')) return 'Invalid email format';
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value != null && value.length < 6
                    ? 'Password too short'
                    : null,
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Builder(
                builder: (context) => ElevatedButton(
                  child: const Text('Submit via Form.of'),
                  onPressed: () {
                    final form = Form.of(context);
                    // ignore: unnecessary_null_comparison
                    if (form != null && form.validate()) {
                      form.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Submitted via Form.of: $_name'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
