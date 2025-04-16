// import 'package:flutter/material.dart';
// import 'package:petsica/core/utils/app_nav_bar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const Center(child: Text("Community")),
//     const Center(child: Text("Store")),
//     const Center(child: Text("Service")),
//     const Center(child: Text("Clinic")),
//     const Center(child: Text("Alarm")),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: AppNavBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() {
//           _currentIndex = index;
//         }),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petsica/helpers/http_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? base64Image;

  // ✅ ميثود لجلب الصورة من API باستخدام التوكن
  Future<void> getImageFromApi() async {
  try {
    final response = await sendAuthorizedRequest(
      url: Uri.parse('http://petsica.runasp.net/api/Products/Seller/products'),
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      if (responseData.isNotEmpty) {
        setState(() {
          base64Image = responseData[0]['photo']; // أول صورة
        });
      } else {
        print('⚠️ No products found.');
      }
    } else {
      print('❌ Failed to load image. Status: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
  }

  @override
  void initState() {
    super.initState();
    getImageFromApi(); // استدعاء الميثود أول ما تفتح الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(
        child: base64Image == null
            ? const CircularProgressIndicator()
            : Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    base64Decode(base64Image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}
