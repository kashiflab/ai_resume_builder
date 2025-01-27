import 'package:flutter/material.dart';
import '../../../domain/models/resume_model.dart';

class ProjectsForm extends StatefulWidget {
  final List<Project>? initialValue;
  final ValueChanged<List<Project>> onChanged;

  const ProjectsForm({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<ProjectsForm> createState() => _ProjectsFormState();
}

class _ProjectsFormState extends State<ProjectsForm> {
  late List<Project> _projects;

  @override
  void initState() {
    super.initState();
    _projects = widget.initialValue?.toList() ?? [];
  }

  void _addProject() {
    setState(() {
      _projects.add(Project(
        name: '',
        description: '',
        url: null,
        technologies: [],
        highlights: [],
        startDate: null,
        endDate: null,
      ));
    });
    widget.onChanged(_projects);
  }

  void _removeProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
    widget.onChanged(_projects);
  }

  void _updateProject(int index, Project project) {
    setState(() {
      _projects[index] = project;
    });
    widget.onChanged(_projects);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _projects.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) {
            return ProjectItemForm(
              key: ValueKey(_projects[index]),
              project: _projects[index],
              onChanged: (project) => _updateProject(index, project),
              onRemove: () => _removeProject(index),
            );
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addProject,
          icon: const Icon(Icons.add),
          label: const Text('Add Project'),
        ),
      ],
    );
  }
}

class ProjectItemForm extends StatefulWidget {
  final Project project;
  final ValueChanged<Project> onChanged;
  final VoidCallback onRemove;

  const ProjectItemForm({
    super.key,
    required this.project,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  State<ProjectItemForm> createState() => _ProjectItemFormState();
}

class _ProjectItemFormState extends State<ProjectItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  late DateTime? _startDate;
  late DateTime? _endDate;
  late List<String> _technologies;
  late List<String> _highlights;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.project.name;
    _descriptionController.text = widget.project.description;
    _urlController.text = widget.project.url ?? '';
    _startDate = widget.project.startDate;
    _endDate = widget.project.endDate;
    _technologies = widget.project.technologies.toList();
    _highlights = widget.project.highlights.toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onChanged(
        Project(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          url: _urlController.text.trim().isEmpty
              ? null
              : _urlController.text.trim(),
          technologies: _technologies,
          highlights: _highlights,
          startDate: _startDate,
          endDate: _endDate,
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
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

  void _addTechnology(String technology) {
    setState(() {
      _technologies.add(technology);
    });
    _handleChange();
  }

  void _removeTechnology(int index) {
    setState(() {
      _technologies.removeAt(index);
    });
    _handleChange();
  }

  void _addHighlight(String highlight) {
    setState(() {
      _highlights.add(highlight);
    });
    _handleChange();
  }

  void _removeHighlight(int index) {
    setState(() {
      _highlights.removeAt(index);
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
                  _nameController.text.isEmpty
                      ? 'New Project'
                      : _nameController.text,
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
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Project Name',
              hintText: 'Enter project name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter project name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Describe your project',
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter project description';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'Project URL (Optional)',
              hintText: 'e.g., https://github.com/username/project',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Start Date (Optional)'),
                  subtitle: Text(
                    _startDate != null
                        ? '${_startDate!.month}/${_startDate!.year}'
                        : 'Not set',
                  ),
                  onTap: () => _selectDate(context, true),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('End Date (Optional)'),
                  subtitle: Text(
                    _endDate != null
                        ? '${_endDate!.month}/${_endDate!.year}'
                        : 'Not set',
                  ),
                  onTap: () => _selectDate(context, false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Technologies Used',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._technologies.asMap().entries.map(
                    (entry) => Chip(
                      label: Text(entry.value),
                      onDeleted: () => _removeTechnology(entry.key),
                    ),
                  ),
              _TechnologyInput(onAdd: _addTechnology),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Key Highlights',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _highlights.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_highlights[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => _removeHighlight(index),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _BulletPointInput(
            onAdd: _addHighlight,
            hintText: 'Add a highlight',
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

class _TechnologyInput extends StatefulWidget {
  final ValueChanged<String> onAdd;

  const _TechnologyInput({required this.onAdd});

  @override
  State<_TechnologyInput> createState() => _TechnologyInputState();
}

class _TechnologyInputState extends State<_TechnologyInput> {
  final _controller = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final technology = _controller.text.trim();
    if (technology.isNotEmpty) {
      widget.onAdd(technology);
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
            hintText: 'Add technology',
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
      label: const Text('Add Technology'),
      onPressed: () {
        setState(() {
          _isEditing = true;
        });
      },
    );
  }
}
