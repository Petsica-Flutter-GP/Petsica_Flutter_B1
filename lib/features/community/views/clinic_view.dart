import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/services/communtiy/petServices/clinicResponseModel.dart';
import 'package:petsica/services/communtiy/petServices/getAllClinics.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  _ClinicsPageState createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  late Future<List<Clinic>> futureClinics;

  @override
  void initState() {
    super.initState();
    futureClinics = ClinicsRequest.getAllClinics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinics'),
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
        child: FutureBuilder<List<Clinic>>(
          future: futureClinics,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No clinics available.'));
            } else {
              final clinics = snapshot.data!;
              return ListView.builder(
                itemCount: clinics.length,
                itemBuilder: (context, index) {
                  final clinic = clinics[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage(AssetData.profileIcon) ,// Fallback image
                        radius: 25,
                      ),
                      title: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Clinic Name: ${clinic.userName}'),
                            Text('Address: ${clinic.address}'),
                            Text('Working Hours: ${clinic.workingHours}'),
                            Text('Contact: ${clinic.contactInfo}'),
                          ],
                        ),
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