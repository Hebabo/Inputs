import 'package:flutter/material.dart';

class KeyboardExample extends StatefulWidget {
  const KeyboardExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KeyboardExampleState createState() => _KeyboardExampleState();
}

class _KeyboardExampleState extends State<KeyboardExample> {
  final FocusNode _focusNode = FocusNode();
  String _message = 'Press any key';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    setState(() {
      _message = 'You pressed: ${event.logicalKey.debugName}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keyboard Listener")),
      body: Center(
        child: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: _handleKeyEvent,
          child: GestureDetector(
            onTap: () => _focusNode.requestFocus(), // get focus on tap
            child: Container(
              width: 300,
              height: 150,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: Text(
                _message,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}