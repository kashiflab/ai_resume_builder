import 'package:flutter/material.dart';
import '../../../domain/models/resume_model.dart';

class EducationForm extends StatefulWidget {
  final List<Education>? initialValue;
  final ValueChanged<List<Education>> onChanged;

  const EducationForm({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  late List<Education> _educationList;

  @override
  void initState() {
    super.initState();
    _educationList = widget.initialValue?.toList() ?? [];
  }

  void _addEducation() {
    setState(() {
      _educationList.add(Education(
        institution: '',
        degree: '',
        field: '',
        startDate: DateTime.now(),
        endDate: null,
        isCurrentlyStudying: true,
        location: null,
        gpa: null,
        achievements: [],
        relevantCourses: [],
      ));
    });
    widget.onChanged(_educationList);
  }

  void _removeEducation(int index) {
    setState(() {
      _educationList.removeAt(index);
    });
    widget.onChanged(_educationList);
  }

  void _updateEducation(int index, Education education) {
    setState(() {
      _educationList[index] = education;
    });
    widget.onChanged(_educationList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _educationList.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) {
            return EducationItemForm(
              key: ValueKey(_educationList[index]),
              education: _educationList[index],
              onChanged: (education) => _updateEducation(index, education),
              onRemove: () => _removeEducation(index),
            );
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addEducation,
          icon: const Icon(Icons.add),
          label: const Text('Add Education'),
        ),
      ],
    );
  }
}

class EducationItemForm extends StatefulWidget {
  final Education education;
  final ValueChanged<Education> onChanged;
  final VoidCallback onRemove;

  const EducationItemForm({
    super.key,
    required this.education,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  State<EducationItemForm> createState() => _EducationItemFormState();
}

class _EducationItemFormState extends State<EducationItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _degreeController = TextEditingController();
  final _fieldController = TextEditingController();
  final _locationController = TextEditingController();
  final _gpaController = TextEditingController();
  late bool _isCurrentlyStudying;
  late DateTime _startDate;
  DateTime? _endDate;
  late List<String> _achievements;
  late List<String> _relevantCourses;

  @override
  void initState() {
    super.initState();
    _institutionController.text = widget.education.institution;
    _degreeController.text = widget.education.degree;
    _fieldController.text = widget.education.field;
    _locationController.text = widget.education.location ?? '';
    _gpaController.text = widget.education.gpa?.toString() ?? '';
    _isCurrentlyStudying = widget.education.isCurrentlyStudying;
    _startDate = widget.education.startDate;
    _endDate = widget.education.endDate;
    _achievements = widget.education.achievements.toList();
    _relevantCourses = widget.education.relevantCourses.toList();
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldController.dispose();
    _locationController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onChanged(
        Education(
          institution: _institutionController.text.trim(),
          degree: _degreeController.text.trim(),
          field: _fieldController.text.trim(),
          startDate: _startDate,
          endDate: _isCurrentlyStudying ? null : _endDate,
          isCurrentlyStudying: _isCurrentlyStudying,
          location: _locationController.text.trim(),
          gpa: double.tryParse(_gpaController.text.trim()),
          achievements: _achievements,
          relevantCourses: _relevantCourses,
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

  void _addCourse(String course) {
    setState(() {
      _relevantCourses.add(course);
    });
    _handleChange();
  }

  void _removeCourse(int index) {
    setState(() {
      _relevantCourses.removeAt(index);
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
                  _institutionController.text.isEmpty
                      ? 'New Education'
                      : _institutionController.text,
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
            controller: _institutionController,
            decoration: const InputDecoration(
              labelText: 'Institution',
              hintText: 'Enter school or university name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter institution name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _degreeController,
            decoration: const InputDecoration(
              labelText: 'Degree',
              hintText: 'e.g., Bachelor of Science, Master of Arts',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter degree';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _fieldController,
            decoration: const InputDecoration(
              labelText: 'Field of Study',
              hintText: 'e.g., Computer Science, Business Administration',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter field of study';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location (Optional)',
              hintText: 'City, State/Province, Country',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _gpaController,
            decoration: const InputDecoration(
              labelText: 'GPA (Optional)',
              hintText: 'e.g., 3.8',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final gpa = double.tryParse(value);
                if (gpa == null) {
                  return 'Please enter a valid number';
                }
                if (gpa < 0 || gpa > 4.0) {
                  return 'GPA should be between 0 and 4.0';
                }
              }
              return null;
            },
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
                child: _isCurrentlyStudying
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
            title: const Text('I am currently studying here'),
            value: _isCurrentlyStudying,
            onChanged: (value) {
              setState(() {
                _isCurrentlyStudying = value ?? false;
              });
              _handleChange();
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Achievements',
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
            'Relevant Courses',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._relevantCourses.asMap().entries.map(
                    (entry) => Chip(
                      label: Text(entry.value),
                      onDeleted: () => _removeCourse(entry.key),
                    ),
                  ),
              _CourseInput(onAdd: _addCourse),
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

  const _BulletPointInput({
    required this.onAdd,
    required this.hintText,
  });

  @override
  State<_BulletPointInput> createState() => _BulletPointInputState();
}

class _BulletPointInputState extends State<_BulletPointInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onAdd(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
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

class _CourseInput extends StatefulWidget {
  final ValueChanged<String> onAdd;

  const _CourseInput({required this.onAdd});

  @override
  State<_CourseInput> createState() => _CourseInputState();
}

class _CourseInputState extends State<_CourseInput> {
  final _controller = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final course = _controller.text.trim();
    if (course.isNotEmpty) {
      widget.onAdd(course);
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
        width: 200,
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Add course name',
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
      label: const Text('Add Course'),
      onPressed: () {
        setState(() {
          _isEditing = true;
        });
      },
    );
  }
}
