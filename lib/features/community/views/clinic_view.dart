/*
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

*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';
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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("Clinics", style: Styles.textStyleQui24),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.push(AppRouter.KHome); // غيري الراوت لو عندك مسار ثاني
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<Clinic>>(
          future: futureClinics,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No clinics available.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            } else {
              final clinics = snapshot.data!;
              return ListView.builder(
                itemCount: clinics.length,
                itemBuilder: (context, index) {
                  final clinic = clinics[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage(AssetData.profileIcon),
                        radius: 30,
                      ),
                      title: Text(
                          'Clinic Name: ${clinic.userName?? "N/A"}\n'
                          'Address: ${clinic.address ?? "N/A"}\n'
                          'Hours: ${clinic.workingHours ?? "N/A"}\n'
                          'Contact: ${clinic.contactInfo ?? "N/A"}',
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                      
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBurgColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Contact feature coming soon!')),
                          );
                        },
                        child: const Text(
                          'Contact',
                          style: TextStyle(color: Colors.white),
                        ),
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
