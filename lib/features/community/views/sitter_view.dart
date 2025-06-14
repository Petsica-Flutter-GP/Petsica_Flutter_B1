import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/services/communtiy/petServices/getAllSitters.dart';
import 'package:petsica/services/communtiy/petServices/sitterResponseModel.dart';

class PetSitterPage extends StatefulWidget {
  const PetSitterPage({super.key});

  @override
  _PetSitterPageState createState() => _PetSitterPageState();
}

class _PetSitterPageState extends State<PetSitterPage> {
  late Future<List<PetSitter>> futureServices;

  @override
  void initState() {
    super.initState();
    futureServices = PetSitterRequest.getPetSitterServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Sitter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<PetSitter>>(
          future: futureServices,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No sitter services available.'));
            } else {
              final services = snapshot.data!;
              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage:AssetImage(AssetData.profileIcon), // Placeholder image
                        radius: 25,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title: ${service.title}'),
                          Text('Price: \$${service.price.toStringAsFixed(2)}'),
                          Text('Location: ${service.location}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBurgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Add contact functionality here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Contact feature coming soon!')),
                          );
                        },
                        child: const Text('Contact', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}