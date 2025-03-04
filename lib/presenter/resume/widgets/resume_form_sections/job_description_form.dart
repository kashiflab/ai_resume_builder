import 'package:flutter/material.dart';

class JobDescriptionForm extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const JobDescriptionForm({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<JobDescriptionForm> createState() => _JobDescriptionFormState();
}

class _JobDescriptionFormState extends State<JobDescriptionForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onChanged(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _handleChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Description',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Paste the job description to optimize your resume for this position',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Paste job description here...',
              border: OutlineInputBorder(),
            ),
            maxLines: 10,
            textInputAction: TextInputAction.newline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the job description';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          Text(
            'The AI will analyze the job description to suggest improvements for your resume',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
