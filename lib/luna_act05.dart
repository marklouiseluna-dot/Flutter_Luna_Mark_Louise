import 'package:flutter/material.dart';

class StudentProfileForm extends StatefulWidget {
  const StudentProfileForm({super.key});

  @override
  State<StudentProfileForm> createState() => _StudentProfileFormState();
}

class _StudentProfileFormState extends State<StudentProfileForm> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();

  // Gender dropdown value
  String? _gender;

  // To display submitted info
  Map<String, String>? _submittedData;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedData = {
          'Full Name': _nameController.text.trim(),
          'Age': _ageController.text.trim(),
          'Gender': _gender ?? 'Not specified',
          'Address': _addressController.text.trim(),
          'Contact Number': _contactController.text.trim(),
          'Email': _emailController.text.trim(),
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile submitted successfully!')),
      );
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _ageController.clear();
    _addressController.clear();
    _contactController.clear();
    _emailController.clear();
    setState(() {
      _gender = null;
      _submittedData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile Form'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter Student Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Full Name
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Age
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter age';
                      }
                      final age = int.tryParse(value.trim());
                      if (age == null || age <= 0 || age > 120) {
                        return 'Please enter a valid age (1-120)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Gender
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.wc),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Address
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.home),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Contact Number
                  TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Contact Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter contact number';
                      }
                      if (value.trim().length < 7) {
                        return 'Contact number is too short';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter email';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Buttons row
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.send),
                          label: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _clearForm,
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Submitted data display
                  if (_submittedData != null) ...[
                    const Divider(thickness: 2),
                    const SizedBox(height: 12),
                    const Text(
                      'Submitted Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _submittedData!.entries
                              .map((entry) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4),
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                        children: [
                                          TextSpan(
                                            text: '${entry.key}: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text: entry.value),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}