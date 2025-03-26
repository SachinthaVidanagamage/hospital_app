

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
