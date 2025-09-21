import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:authentication/pages/provider_form_page.dart';

class ProvidersDatabase {
  final table = Supabase.instance.client.from('providers');

  Future<void> createProvider(Map<String, dynamic> data) async {
    await table.insert(data);
  }

  Future<void> updateProvider(dynamic id, Map<String, dynamic> data) async {
    await table.update(data).eq('id', id);
  }

  Future<void> deleteProvider(dynamic id) async {
    await table.delete().eq('id', id);
  }
}

class ProviderListPage extends StatefulWidget {
  const ProviderListPage({super.key});

  @override
  State<ProviderListPage> createState() => _ProviderListPageState();
}

class _ProviderListPageState extends State<ProviderListPage> {
  final providersdb = ProvidersDatabase();

  void deleteProvider(dynamic id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete provider?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await providersdb.deleteProvider(id);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Deletion done")),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Providers"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProviderFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: providersdb.table.stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No providers yet'));
          }
          final providers = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final provider = providers[index];
              return _ProviderCard(
                name: provider['name'] ?? 'Unknown',
                service: provider['service'] ?? 'Unknown',
                rating: (provider['rating'] as num?)?.toDouble() ?? 0.0,
                location: provider['location'] ?? 'Unknown',
                onEdit: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProviderFormPage(
                      id: provider['id'],
                      initialName: provider['name'] ?? '',
                      initialService: provider['service'] ?? '',
                      initialRating: (provider['rating'] as num?)?.toDouble() ?? 0.0,
                      initialLocation: provider['location'] ?? '',
                    ),
                  ),
                ),
                onDelete: () => deleteProvider(provider['id']),
              );
            },
          );
        },
      ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  final String name;
  final String service;
  final double rating;
  final String location;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _ProviderCard({
    required this.name,
    required this.service,
    required this.rating,
    required this.location,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(name.isNotEmpty ? name.substring(0, 1) : '?'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(service, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(rating.toStringAsFixed(1)),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on_outlined, size: 16),
                      const SizedBox(width: 4),
                      Flexible(child: Text(location, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            ),
            if (onEdit != null)
              IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            if (onDelete != null)
              IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}