import 'package:flutter/material.dart';

class SkillsForm extends StatefulWidget {
  final List<String>? initialValue;
  final ValueChanged<List<String>> onChanged;

  const SkillsForm({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  late List<String> _skills;

  @override
  void initState() {
    super.initState();
    _skills = widget.initialValue?.toList() ?? [];
  }

  void _addSkill(String skill) {
    setState(() {
      _skills.add(skill);
    });
    widget.onChanged(_skills);
  }

  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
    widget.onChanged(_skills);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Add your technical and professional skills',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._skills.asMap().entries.map(
                  (entry) => Chip(
                    label: Text(entry.value),
                    onDeleted: () => _removeSkill(entry.key),
                  ),
                ),
            _SkillInput(onAdd: _addSkill),
          ],
        ),
      ],
    );
  }
}

class _SkillInput extends StatefulWidget {
  final ValueChanged<String> onAdd;

  const _SkillInput({required this.onAdd});

  @override
  State<_SkillInput> createState() => _SkillInputState();
}

class _SkillInputState extends State<_SkillInput> {
  final _controller = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final skill = _controller.text.trim();
    if (skill.isNotEmpty) {
      widget.onAdd(skill);
      _controller.clear();
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return SizedBox(
        width: 150,
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Add skill',
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
          ),
          onSubmitted: (_) => _handleSubmit(),
          onEditingComplete: _handleSubmit,
        ),
      );
    }

    return ActionChip(
      avatar: const Icon(Icons.add, size: 16),
      label: const Text('Add Skill'),
      onPressed: () {
        setState(() {
          _isEditing = true;
        });
      },
    );
  }
}
