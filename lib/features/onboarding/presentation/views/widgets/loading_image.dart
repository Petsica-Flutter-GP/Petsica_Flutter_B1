import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';

class ImageWithLoading extends StatelessWidget {
  final String imagePath;

  const  ImageWithLoading({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9, // ✅ تكبير العرض إلى 90%
        height: MediaQuery.of(context).size.height * 0.5, // ✅ تكبير الارتفاع إلى 50%
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover, // ✅ جعل الصورة تغطي الحاوية بالكامل
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red, size: 50);
              },
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame == null) {
                  return const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: kBurgColor,
                      strokeWidth: 5,
                    ),
                  );
                }
                return child;
              },
            ),
          ],
        ),
      ),
    );
  }
}
