import 'package:flutter/material.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/styles.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Avatar + Name + Time
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(AssetData.profileIcon),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pero Osama',
                  style: Styles.textStyleQui20.copyWith(
                    color: kBurgColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// Post title
          const Text(
            'This is what I learned in my recent course',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),

          /// Post content
          const Text(
            '"The whole secret of existence"\n\n'
            '"The whole secret of existence lies in the pursuit of meaning, purpose, and connection. '
            'It is a delicate dance between self-discovery, compassion for others, and embracing the ever-unfolding mysteries of life. '
            'Finding harmony in the ebb and flow of experiences, we unlock the profound beauty that resides within our shared journey."',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          /// Like & Comment buttons
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? kBurgColor : Colors.grey,
                ),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.comment_outlined, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
