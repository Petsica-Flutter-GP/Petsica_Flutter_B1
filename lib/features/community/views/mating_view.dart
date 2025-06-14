import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/services/communtiy/petServices/getAllMating.dart';
import 'package:petsica/services/communtiy/petServices/matingResponseModel.dart';

class PetMatingPage extends StatefulWidget {
  const PetMatingPage({super.key});

  @override
  _PetMatingPageState createState() => _PetMatingPageState();
}

class _PetMatingPageState extends State<PetMatingPage> {
  late Future<List<PetMating>> futurePets;

  @override
  void initState() {
    super.initState();
    futurePets = PetMatingRequest.getPetMatingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mating'),
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
        child: FutureBuilder<List<PetMating>>(
          future: futurePets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No pets available for mating.'));
            } else {
              final pets = snapshot.data!;
              return ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage(AssetData.profileIcon), // Fallback image
                        radius: 25,
                      ),
                      title: Text('${pet.userName}'),
                      subtitle: Text('Gender: ${pet.gender} - Name: ${pet.name}'),
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
                        child: const Text('Contact',style: TextStyle(color: Colors.white),),
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