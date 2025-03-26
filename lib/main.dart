import 'package:flutter/material.dart';
import 'hospital_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> hospitals = [];
  String searchQuery = '';

  void _addHospital(Map<String, String> hospital) {
    setState(() {
      hospitals.add(hospital);
    });
  }

  void _editHospital(int index, Map<String, String> updatedHospital) {
    setState(() {
      hospitals[index] = updatedHospital;
    });
  }

  void _deleteHospital(int index) {
    setState(() {
      hospitals.removeAt(index);
    });
  }

  void _showHospitalDetails(BuildContext context, Map<String, String> hospital) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(hospital['name'] ?? 'Hospital Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Address: ${hospital['address'] ?? ''}'),
              const SizedBox(height: 8),
              Text('Contact: ${hospital['contact'] ?? ''}'),
              const SizedBox(height: 8),
              Text('Emergency: ${hospital['emergency'] ?? ''}'),
              const SizedBox(height: 8),
              Text('Blood Bank: ${hospital['bloodBank'] ?? ''}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredHospitals = hospitals.where((hospital) {
      return hospital['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital List'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Hospital',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredHospitals.isEmpty
                ? const Center(child: Text('No hospitals available.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: filteredHospitals.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            filteredHospitals[index]['name'] ?? '',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Text(
                            filteredHospitals[index]['address'] ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.visibility, color: Colors.green),
                                tooltip: 'View Details',
                                onPressed: () {
                                  _showHospitalDetails(context, filteredHospitals[index]);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                tooltip: 'Edit',
                                onPressed: () async {
                                  final updatedHospital = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HospitalForm(
                                        hospital: filteredHospitals[index],
                                        onSave: (hospital) => _editHospital(index, hospital),
                                        onDelete: () => _deleteHospital(index),
                                      ),
                                    ),
                                  );
                                  if (updatedHospital != null) {
                                    _editHospital(index, updatedHospital);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Delete',
                                onPressed: () {
                                  _deleteHospital(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newHospital = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalForm(
                onSave: (hospital) => _addHospital(hospital),
              ),
            ),
          );
          if (newHospital != null) {
            _addHospital(newHospital);
          }
        },
        backgroundColor: Colors.blue,
        tooltip: 'Add Hospital',
        child: const Icon(Icons.add),
      ),
    );
  }
}