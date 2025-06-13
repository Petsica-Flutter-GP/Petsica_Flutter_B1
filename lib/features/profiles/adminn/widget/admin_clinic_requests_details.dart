import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/clinicRequestDetails/clinic_request_details_cubit.dart';
import 'package:petsica/features/profiles/adminn/cubit/profileCubit/clinicRequestDetails/clinic_request_details_state.dart';

class ClinicDetailsView extends StatelessWidget {
  final String userId;

  const ClinicDetailsView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClinicDetailsCubit()..fetchClinicDetails(userId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Clinic Details')),
        body: BlocBuilder<ClinicDetailsCubit, ClinicDetailsState>(
          builder: (context, state) {
            if (state is ClinicDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ClinicDetailsError) {
              return Center(child: Text("❌ ${state.message}"));
            } else if (state is ClinicDetailsLoaded) {
              final clinic = state.clinicDetails;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ✅ صورة المستخدم
                    if (clinic.photo != "string")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("User Photo:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              base64Decode(clinic.photo),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                    /// ✅ صورة الموافقة
                    if (clinic.approvalPhoto != "string")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Approval Photo:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              base64Decode(clinic.approvalPhoto),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                    /// ✅ باقي البيانات النصية
                    Text("👤 Name: ${clinic.userName ?? 'N/A'}"),
                    Text("📧 Email: ${clinic.email ?? 'N/A'}"),
                    Text("🏠 Address: ${clinic.address ?? 'N/A'}"),
                    Text("🆔 National ID: ${clinic.nationalID ?? 'N/A'}"),
                    Text("📞 Contact Info: ${clinic.contactInfo ?? 'N/A'}"),
                    Text("⏰ Working Hours: ${clinic.workingHours ?? 'N/A'}"),
                    Text("🏷️ Type: ${clinic.type ?? 'N/A'}"),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
