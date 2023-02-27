import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osar_pasar/widgets/custom_text_field.dart';

import '../utils/colors.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(Get.context!).textTheme;
    var theme = Theme.of(Get.context!);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: const Color(0xFF494949).withOpacity(0.06),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Booking Summary",
          style: textTheme.titleLarge!
              .copyWith(fontSize: 16, color: AppColors.textColor),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Packers and Movers Name"),
            const Text("serviceprovider@gmail.com"),
            const SizedBox(
              height: 27,
            ),
            const CustomTextField(
              readOnly: true,
              // initial: "Street No-7, Lakeside, Pokhara",
              hint: "Street No-7, Lakeside, Pokhara",
            ),
            const SizedBox(
              height: 9,
            ),
            const Center(child: Text("To")),
            const SizedBox(
              height: 9,
            ),
            const CustomTextField(
              readOnly: true,
              // initial: "Street No-7, Lakeside, Pokhara",
              hint: "Prithivi-chowk, Pokhara",
            ),
            const SizedBox(
              height: 27,
            ),
            const Text("Item Summary"),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Item Summary"),
                        Text("1"),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 46, right: 35, left: 35),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: const Color(0xff00183F),
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () {
            // (() => Get.to(() => AddressPage()))
          },
          child: const Text("Send Request"),
        ),
      ),
    );
  }
}
