/*

import 'package:flutter/material.dart';

class HospitalForm extends StatefulWidget {
  final Map<String, String>? hospital; // Existing hospital data (for editing)
  final Function(Map<String, String>) onSave; // Callback to save changes
  final Function()? onDelete; // Callback to delete hospital (optional)

  const HospitalForm({super.key, this.hospital, required this.onSave, this.onDelete});

  @override
  State<HospitalForm> createState() => _HospitalFormState();
}

class _HospitalFormState extends State<HospitalForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _contactController;
  bool _emergencyAvailable = false;
  int _bloodBankUnits = 0;

  @override
  void initState() {
    super.initState();

    // Pre-fill form fields when editing
    _nameController = TextEditingController(text: widget.hospital?['name'] ?? '');
    _addressController = TextEditingController(text: widget.hospital?['address'] ?? '');
    _contactController = TextEditingController(text: widget.hospital?['contact'] ?? '');
    _emergencyAvailable = widget.hospital?['emergency'] == 'Yes';
    _bloodBankUnits = int.tryParse(widget.hospital?['bloodBank']?.split(' ')[0] ?? '0') ?? 0;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final hospital = {
        'name': _nameController.text,
        'address': _addressController.text,
        'contact': _contactController.text,
        'emergency': _emergencyAvailable ? 'Yes' : 'No',
        'bloodBank': '$_bloodBankUnits units',
      };
      widget.onSave(hospital);
      Navigator.pop(context);
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Hospital'),
        content: const Text('Are you sure you want to delete this hospital?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel deletion
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDelete?.call();
              Navigator.pop(context);
              Navigator.pop(context); // Go back to the hospital list
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hospital == null ? 'Add Hospital' : 'Edit Hospital'),
        actions: widget.hospital != null
            ? [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _confirmDelete,
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Hospital Name'),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Enter an address' : null,
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Enter a contact number' : null,
              ),
              SwitchListTile(
                title: const Text('Emergency Available'),
                value: _emergencyAvailable,
                onChanged: (value) => setState(() => _emergencyAvailable = value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Blood Bank Units'),
                keyboardType: TextInputType.number,
                initialValue: _bloodBankUnits.toString(),
                onChanged: (value) => _bloodBankUnits = int.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save Hospital'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






import 'package:flutter/material.dart';

class HospitalForm extends StatefulWidget {
  final Map<String, String>? hospital; // Existing hospital data (for editing)
  final Function(Map<String, String>) onSave; // Callback to save changes
  final Function()? onDelete; // Callback to delete hospital (optional)

  const HospitalForm({super.key, this.hospital, required this.onSave, this.onDelete});

  @override
  State<HospitalForm> createState() => _HospitalFormState();
}

class _HospitalFormState extends State<HospitalForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _contactController;
  bool _emergencyAvailable = false;
  int _bloodBankUnits = 0;

  @override
  void initState() {
    super.initState();

    // Pre-fill form fields when editing
    _nameController = TextEditingController(text: widget.hospital?['name'] ?? '');
    _addressController = TextEditingController(text: widget.hospital?['address'] ?? '');
    _contactController = TextEditingController(text: widget.hospital?['contact'] ?? '');
    _emergencyAvailable = widget.hospital?['emergency'] == 'Yes';
    _bloodBankUnits = int.tryParse(widget.hospital?['bloodBank']?.split(' ')[0] ?? '0') ?? 0;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final hospital = {
        'name': _nameController.text,
        'address': _addressController.text,
        'contact': _contactController.text,
        'emergency': _emergencyAvailable ? 'Yes' : 'No',
        'bloodBank': '$_bloodBankUnits units',
      };
      widget.onSave(hospital);
      Navigator.pop(context);
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Hospital'),
        content: const Text('Are you sure you want to delete this hospital?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel deletion
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDelete?.call();
              Navigator.pop(context);
              Navigator.pop(context); // Go back to the hospital list
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hospital == null ? 'Add Hospital' : 'Edit Hospital'),
        actions: widget.hospital != null
            ? [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _confirmDelete,
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Hospital Name Field
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Hospital Name',
                      prefixIcon: const Icon(Icons.local_hospital),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                  ),
                ),
                // Address Field
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter an address' : null,
                  ),
                ),
                // Contact Field
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: _contactController,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? 'Enter a contact number' : null,
                  ),
                ),
                // Emergency Available Switch
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: SwitchListTile(
                    title: const Text('Emergency Available'),
                    value: _emergencyAvailable,
                    onChanged: (value) => setState(() => _emergencyAvailable = value),
                  ),
                ),
                // Blood Bank Units Field
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Blood Bank Units',
                      prefixIcon: const Icon(Icons.bloodtype),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _bloodBankUnits.toString(),
                    onChanged: (value) => _bloodBankUnits = int.tryParse(value) ?? 0,
                  ),
                ),
                const SizedBox(height: 20),
                // Save Button
                ElevatedButton(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
    backgroundColor: Theme.of(context).primaryColor, // Corrected from 'primary' to 'backgroundColor'
  ),
  onPressed: _submitForm,
  child: const Text('Save Hospital'),
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';

class HospitalForm extends StatefulWidget {
  final Map<String, String>? hospital;
  final Function(Map<String, String>) onSave;
  final Function()? onDelete;

  const HospitalForm({super.key, this.hospital, required this.onSave, this.onDelete});

  @override
  State<HospitalForm> createState() => _HospitalFormState();
}

class _HospitalFormState extends State<HospitalForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _contactController;
  bool _emergencyAvailable = false;
  int _bloodBankUnits = 0;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.hospital?['name'] ?? '');
    _addressController = TextEditingController(text: widget.hospital?['address'] ?? '');
    _contactController = TextEditingController(text: widget.hospital?['contact'] ?? '');
    _emergencyAvailable = widget.hospital?['emergency'] == 'Yes';
    _bloodBankUnits = int.tryParse(widget.hospital?['bloodBank']?.split(' ')[0] ?? '0') ?? 0;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final hospital = {
        'name': _nameController.text,
        'address': _addressController.text,
        'contact': _contactController.text,
        'emergency': _emergencyAvailable ? 'Yes' : 'No',
        'bloodBank': '$_bloodBankUnits units',
      };
      widget.onSave(hospital);
      Navigator.pop(context);
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this hospital? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onDelete?.call();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.hospital == null ? 'Add Hospital' : 'Edit Hospital'),
        actions: widget.hospital != null
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: _confirmDelete,
                  tooltip: 'Delete Hospital',
                ),
              ]
            : [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      controller: _nameController,
                      label: 'Hospital Name',
                      icon: Icons.local_hospital,
                      validator: (value) => value!.isEmpty ? 'Please enter hospital name' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Address',
                      icon: Icons.location_on,
                      maxLines: 2,
                      validator: (value) => value!.isEmpty ? 'Please enter address' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _contactController,
                      label: 'Contact Number',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? 'Please enter contact number' : null,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      title: const Text('Emergency Services'),
                      subtitle: const Text('Available 24/7'),
                      value: _emergencyAvailable,
                      activeColor: Colors.green,
                      onChanged: (value) => setState(() => _emergencyAvailable = value),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Blood Bank Units',
                      icon: Icons.bloodtype,
                      keyboardType: TextInputType.number,
                      initialValue: _bloodBankUnits.toString(),
                      onChanged: (value) => _bloodBankUnits = int.tryParse(value) ?? 0,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: _submitForm,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green[600], // Changed to a clear green color
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2, // Added slight elevation for better visibility
    ),
    child: Text(
      'Save Hospital',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Colors.white, // Ensured white text for contrast
        fontWeight: FontWeight.bold, // Added bold for emphasis
      ),
    ),
  ),
),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? initialValue,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}