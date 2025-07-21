//[1]  Autocomplete
import 'package:flutter/material.dart';
import 'dart:async';
//import 'dart:convert'; // للتجربة فقط مع async، ممكن تشيله لو مش محتاجه
// import 'package:http/http.dart' as http; // فعّل لو حابب تجرب API حقيقي

class AutoComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AutoCompleteExample());
  }
}

class AutoCompleteExample extends StatefulWidget {
  const AutoCompleteExample({super.key});

  @override
  State<AutoCompleteExample> createState() => _AutoCompleteExampleState();
}

class _AutoCompleteExampleState extends State<AutoCompleteExample> {
  final List<String> countries = [
    'Egypt',
    'Ethiopia',
    'England',
    'France',
    'Finland',
    'Germany',
    'Greece',
  ];

  // For RawAutocomplete
  final TextEditingController _rawController = TextEditingController();
  final FocusNode _rawFocusNode = FocusNode();

  // For async autocomplete (simulated)
  Future<List<String>> fetchSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 500)); // simulate delay
    return countries
        .where((option) => option.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Autocomplete Types')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1️⃣ Basic Autocomplete:', style: TextStyle(fontSize: 18)),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '')
                    return const Iterable<String>.empty();
                  return countries.where((String option) {
                    return option.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    );
                  });
                },
                onSelected: (value) {
                  print("Basic Selected: $value");
                },
              ),
              SizedBox(height: 30),

              Text('2️⃣ Raw Autocomplete:', style: TextStyle(fontSize: 18)),
              RawAutocomplete<String>(
                textEditingController: _rawController,
                focusNode: _rawFocusNode,
                optionsBuilder: (textEditingValue) {
                  return countries.where(
                    (option) => option.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
                  );
                },
                fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type a country',
                    ),
                  );
                },
                optionsViewBuilder: (context, onSelect, options) {
                  return Material(
                    elevation: 4.0,
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      children: options
                          .map(
                            (option) => ListTile(
                              title: Text(option),
                              onTap: () => onSelect(option),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
                onSelected: (value) {
                  print("Raw Selected: $value");
                },
              ),
              SizedBox(height: 30),

              Text('3️⃣ Async Autocomplete:', style: TextStyle(fontSize: 18)),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text == '')
                    return const Iterable<String>.empty();
                  return await fetchSuggestions(textEditingValue.text);
                },
                onSelected: (value) {
                  print("Async Selected: $value");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
