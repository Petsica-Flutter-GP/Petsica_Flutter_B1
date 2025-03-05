// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationField extends StatefulWidget {
//   final Function(String) onLocationSelected;

//   const LocationField({Key? key, required this.onLocationSelected}) : super(key: key);

//   @override
//   _LocationFieldState createState() => _LocationFieldState();
// }

// class _LocationFieldState extends State<LocationField> {
//   final TextEditingController _locationController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _getCurrentLocation() async {
//     setState(() => _isLoading = true);

//     try {
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.deniedForever) {
//         throw Exception("Location permissions are permanently denied.");
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       String locationText = "Lat: ${position.latitude}, Long: ${position.longitude}";
//       _locationController.text = locationText;
//       widget.onLocationSelected(locationText);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error getting location: $e")),
//       );
//     }

//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _locationController,
//       decoration: InputDecoration(
//         labelText: "Location",
//         suffixIcon: _isLoading
//             ? const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CircularProgressIndicator(),
//               )
//             : IconButton(
//                 icon: const Icon(Icons.my_location),
//                 onPressed: _getCurrentLocation,
//               ),
//       ),
//       onChanged: widget.onLocationSelected,
//     );
//   }
// }
