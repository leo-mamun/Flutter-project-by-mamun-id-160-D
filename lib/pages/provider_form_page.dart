import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProvidersDatabase {
  final table = Supabase.instance.client.from('providers');

  Future<void> createProvider(Map<String, dynamic> data) async {
    await table.insert(data);
  }

  Future<void> updateProvider(dynamic id, Map<String, dynamic> data) async {
    await table.update(data).eq('id', id);
  }
}

class ProviderFormPage extends StatefulWidget {
  final dynamic id;
  final String initialName;
  final String initialService;
  final double initialRating;
  final String initialLocation;

  const ProviderFormPage({
    super.key,
    this.id,
    this.initialName = '',
    this.initialService = '',
    this.initialRating = 0.0,
    this.initialLocation = '',
  });

  @override
  State<ProviderFormPage> createState() => _ProviderFormPageState();
}

class _ProviderFormPageState extends State<ProviderFormPage> {
  final providersdb = ProvidersDatabase();
  final _nameController = TextEditingController();
  final _serviceController = TextEditingController();
  final _ratingController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _serviceController.text = widget.initialService;
    _ratingController.text = widget.initialRating.toString();
    _locationController.text = widget.initialLocation;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serviceController.dispose();
    _ratingController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> saveProvider() async {
    final name = _nameController.text;
    final service = _serviceController.text;
    final ratingText = _ratingController.text;
    final location = _locationController.text;

    if (name.isEmpty || service.isEmpty || ratingText.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final rating = double.tryParse(ratingText) ?? 0.0;
    final data = {
      'name': name,
      'service': service,
      'rating': rating,
      'location': location,
    };

    try {
      if (widget.id == null) {
        await providersdb.createProvider(data);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Provider added")),
          );
        }
      } else {
        await providersdb.updateProvider(widget.id, data);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Provider updated")),
          );
        }
      }
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? "Add Provider" : "Edit Provider"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _serviceController,
              decoration: const InputDecoration(
                labelText: 'Service',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Rating',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              ),
              onPressed: saveProvider,
              child: Text(widget.id == null ? 'Add Provider' : 'Update Provider'),
            ),
          ],
        ),
      ),
    );
  }
}