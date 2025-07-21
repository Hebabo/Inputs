import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _savedEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Combined Form Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 1. autovalidateMode
              FormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => val!.isEmpty ? 'Required' : null,
                builder: (state) => TextField(
                  onChanged: state.didChange,
                  decoration: InputDecoration(
                    focusColor: Colors.green,
                    labelText: 'Auto Validate Field',
                    errorText: state.errorText,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 2. builder with checkbox
              FormField<bool>(
                initialValue: false,
                builder: (state) => CheckboxListTile(
                  title: const Text('Accept Terms'),
                  value: state.value,
                  onChanged: (val) => state.didChange(val),
                  subtitle: state.hasError
                      ? Text(
                          state.errorText ?? '',
                          style: const TextStyle(color: Colors.red),
                        )
                      : null,
                ),
                validator: (val) =>
                    val == false ? 'You must accept terms' : null,
              ),
              const SizedBox(height: 20),

              // 3. enabled false field
              IgnorePointer(
                child: FormField<String>(
                  builder: (state) => TextField(
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Disabled Field'),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 4. errorBuilder
              FormField<String>(
                validator: (val) => val!.isEmpty ? 'Error occurred' : null,
                errorBuilder: (context, errorText) {
                  return Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        errorText,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                builder: (state) => TextField(
                  onChanged: state.didChange,
                  decoration: const InputDecoration(
                    labelText: 'Custom Error Field',
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 5. forceErrorText
              FormField<String>(
                forceErrorText: 'Forced Error!',
                builder: (state) => TextField(
                  decoration: InputDecoration(
                    labelText: 'Forced Error Field',
                    errorText: state.errorText,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 6. onSaved field
              FormField<String>(
                onSaved: (val) {
                  _savedEmail = val ?? '';
                },
                builder: (state) => TextField(
                  onChanged: state.didChange,
                  decoration: InputDecoration(
                    labelText: 'Email (onSaved)',
                    errorText: state.errorText,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 7. validator field
              FormField<String>(
                validator: (val) =>
                    val != null && val.length < 4 ? 'Too short' : null,
                builder: (state) => TextField(
                  onChanged: state.didChange,
                  decoration: InputDecoration(
                    labelText: 'Password (min 4 chars)',
                    errorText: state.errorText,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Saved Email: $_savedEmail')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
