import 'package:flutter/material.dart';
import 'package:petsica/core/utils/app_button.dart';
import 'package:petsica/core/utils/asset_data.dart';
import 'package:petsica/core/utils/store_arrow_back.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/store/widgets/cart_item_card.dart';

class CheckOutViewBody extends StatefulWidget {
  const CheckOutViewBody({super.key});

  @override
  State<CheckOutViewBody> createState() => _CheckOutViewBodyState();
}

class _CheckOutViewBodyState extends State<CheckOutViewBody> {
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Product Name",
      "price": 50,
      "quantity": 2,
      "image": AssetData.productImage,
    },
    {
      "name": "Product Name",
      "price": 30,
      "quantity": 1,
      "image": AssetData.productImage,
    },
    {
      "name": "Product Name",
      "price": 30,
      "quantity": 1,
      "image": AssetData.productImage,
    },
  ];

  double getTotalPrice() {
    return cartItems.fold(
        0, (total, item) => total + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Cart",
            style: Styles.textStyleQu28,
          ),
          centerTitle: true,
          leading: const StoreArrowBack()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${cartItems.length} Products",
                      style: Styles.textStyleCom18),
                  Text("Total Price: \$${getTotalPrice().toStringAsFixed(2)}",
                      style: Styles.textStyleCom18),
                ],
              ),
            ),

            // ✅ قائمة المنتجات ✅
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return SizedBox(
                    height: 140,
                    child: Stack(
                      children: [
                        CartItemCard(
                          item: item,
                          onDelete: () {
                            setState(() {
                              cartItems.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ✅ يضع الزر دائمًا في الأسفل ✅
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: AppButton(
                text: 'CheckOut',
                border: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
