import 'package:flutter/material.dart';

class AddBookDialog extends StatefulWidget {
  final String defaultName;
  const AddBookDialog({super.key, required this.defaultName});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(viewInsets: EdgeInsets.zero),
      child: AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Enter Book Name"),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: _controller,
            autofocus: true,
            maxLines: 1,
            maxLength: 50,
            decoration: const InputDecoration(
              hintText: "Book Title",
              border: OutlineInputBorder(),
              counterText: "",
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).textTheme.bodyMedium?.color),
            child: const Text(
              "Cancel",
              style: TextStyle(height: 1.0),
              strutStyle: StrutStyle(
                forceStrutHeight: true,
                height: 1,
              ),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, _controller.text),
            child: const Text(
              "Save",
              style: TextStyle(height: 1.0),
              strutStyle: StrutStyle(
                forceStrutHeight: true,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}