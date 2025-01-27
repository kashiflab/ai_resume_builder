import 'package:flutter/material.dart';
import '../../../domain/models/resume_model.dart';

class WorkExperienceForm extends StatefulWidget {
  final List<WorkExperience>? initialValue;
  final ValueChanged<List<WorkExperience>> onChanged;

  const WorkExperienceForm({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<WorkExperienceForm> createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  late List<WorkExperience> _experiences;

  @override
  void initState() {
    super.initState();
    _experiences = widget.initialValue?.toList() ?? [];
  }

  void _addExperience() {
    setState(() {
      _experiences.add(WorkExperience(
        company: '',
        position: '',
        startDate: DateTime.now(),
        endDate: null,
        isCurrentRole: true,
        location: '',
        responsibilities: [],
        achievements: [],
        keywords: [],
      ));
    });
    widget.onChanged(_experiences);
  }

  void _removeExperience(int index) {
    setState(() {
      _experiences.removeAt(index);
    });
    widget.onChanged(_experiences);
  }

  void _updateExperience(int index, WorkExperience experience) {
    setState(() {
      _experiences[index] = experience;
    });
    widget.onChanged(_experiences);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _experiences.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) {
            return WorkExperienceItemForm(
              key: ValueKey(_experiences[index]),
              experience: _experiences[index],
              onChanged: (experience) => _updateExperience(index, experience),
              onRemove: () => _removeExperience(index),
            );
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addExperience,
          icon: const Icon(Icons.add),
          label: const Text('Add Work Experience'),
        ),
      ],
    );
  }
}

class WorkExperienceItemForm extends StatefulWidget {
  final WorkExperience experience;
  final ValueChanged<WorkExperience> onChanged;
  final VoidCallback onRemove;

  const WorkExperienceItemForm({
    super.key,
    required this.experience,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  State<WorkExperienceItemForm> createState() => _WorkExperienceItemFormState();
}

class _WorkExperienceItemFormState extends State<WorkExperienceItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _locationController = TextEditingController();
  late bool _isCurrentRole;
  late DateTime _startDate;
  DateTime? _endDate;
  late List<String> _achievements;
  late List<String> _responsibilities;
  late List<String> _keywords;

  @override
  void initState() {
    super.initState();
    _companyController.text = widget.experience.company;
    _positionController.text = widget.experience.position;
    _locationController.text = widget.experience.location;
    _isCurrentRole = widget.experience.isCurrentRole;
    _startDate = widget.experience.startDate;
    _endDate = widget.experience.endDate;
    _achievements = widget.experience.achievements.toList();
    _responsibilities = widget.experience.responsibilities.toList();
    _keywords = widget.experience.keywords.toList();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onChanged(
        WorkExperience(
          company: _companyController.text.trim(),
          position: _positionController.text.trim(),
          location: _locationController.text.trim(),
          startDate: _startDate,
          endDate: _isCurrentRole ? null : _endDate,
          isCurrentRole: _isCurrentRole,
          responsibilities: _responsibilities,
          achievements: _achievements,
          keywords: _keywords,
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : (_endDate ?? DateTime.now()),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
      _handleChange();
    }
  }

  void _addResponsibility(String responsibility) {
    setState(() {
      _responsibilities.add(responsibility);
    });
    _handleChange();
  }

  void _removeResponsibility(int index) {
    setState(() {
      _responsibilities.removeAt(index);
    });
    _handleChange();
  }

  void _addAchievement(String achievement) {
    setState(() {
      _achievements.add(achievement);
    });
    _handleChange();
  }

  void _removeAchievement(int index) {
    setState(() {
      _achievements.removeAt(index);
    });
    _handleChange();
  }

  void _addKeyword(String keyword) {
    setState(() {
      _keywords.add(keyword);
    });
    _handleChange();
  }

  void _removeKeyword(int index) {
    setState(() {
      _keywords.removeAt(index);
    });
    _handleChange();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _handleChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _companyController.text.isEmpty
                      ? 'New Work Experience'
                      : _companyController.text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: widget.onRemove,
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _companyController,
            decoration: const InputDecoration(
              labelText: 'Company',
              hintText: 'Enter company name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter company name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _positionController,
            decoration: const InputDecoration(
              labelText: 'Position',
              hintText: 'Enter your job title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter position';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'City, State/Province, Country',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Start Date'),
                  subtitle: Text(
                    '${_startDate.month}/${_startDate.year}',
                  ),
                  onTap: () => _selectDate(context, true),
                ),
              ),
              Expanded(
                child: _isCurrentRole
                    ? const SizedBox()
                    : ListTile(
                        title: const Text('End Date'),
                        subtitle: Text(
                          _endDate != null
                              ? '${_endDate!.month}/${_endDate!.year}'
                              : 'Select date',
                        ),
                        onTap: () => _selectDate(context, false),
                      ),
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('I currently work here'),
            value: _isCurrentRole,
            onChanged: (value) {
              setState(() {
                _isCurrentRole = value ?? false;
              });
              _handleChange();
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Responsibilities',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _responsibilities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_responsibilities[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => _removeResponsibility(index),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _BulletPointInput(
            onAdd: _addResponsibility,
            hintText: 'Add a responsibility',
          ),
          const SizedBox(height: 16),
          Text(
            'Key Achievements',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _achievements.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_achievements[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => _removeAchievement(index),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _BulletPointInput(
            onAdd: _addAchievement,
            hintText: 'Add an achievement',
          ),
          const SizedBox(height: 16),
          Text(
            'Keywords',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._keywords.asMap().entries.map(
                    (entry) => Chip(
                      label: Text(entry.value),
                      onDeleted: () => _removeKeyword(entry.key),
                    ),
                  ),
              _KeywordInput(onAdd: _addKeyword),
            ],
          ),
        ],
      ),
    );
  }
}

class _BulletPointInput extends StatefulWidget {
  final ValueChanged<String> onAdd;
  final String hintText;

  const _BulletPointInput({required this.onAdd, required this.hintText});

  @override
  State<_BulletPointInput> createState() => _BulletPointInputState();
}

class _BulletPointInputState extends State<_BulletPointInput> {
  final _bulletPointController = TextEditingController();

  @override
  void dispose() {
    _bulletPointController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final bulletPoint = _bulletPointController.text.trim();
    if (bulletPoint.isNotEmpty) {
      widget.onAdd(bulletPoint);
      _bulletPointController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _bulletPointController,
            decoration: InputDecoration(
              hintText: widget.hintText,
            ),
            onFieldSubmitted: (_) => _handleSubmit(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: _handleSubmit,
        ),
      ],
    );
  }
}

class _KeywordInput extends StatefulWidget {
  final ValueChanged<String> onAdd;

  const _KeywordInput({required this.onAdd});

  @override
  State<_KeywordInput> createState() => _KeywordInputState();
}

class _KeywordInputState extends State<_KeywordInput> {
  final _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final keyword = _keywordController.text.trim();
    if (keyword.isNotEmpty) {
      widget.onAdd(keyword);
      _keywordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _keywordController,
            decoration: const InputDecoration(
              hintText: 'Add a keyword',
            ),
            onFieldSubmitted: (_) => _handleSubmit(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: _handleSubmit,
        ),
      ],
    );
  }
}
