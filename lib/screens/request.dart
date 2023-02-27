import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:osar_pasar/utils/image_path.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

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
          title: const Text(
            "Request",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: ListView.builder(
                itemCount: 14,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    // padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("Today"),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Service Provider’s Name"),
                                Text("PENDING"),
                              ],
                            ),
                          ],
                        ),
                        SvgPicture.asset(AllImages.waiting),
                      ],
                    ),
                  );
                }),
          ),
        ),);
  }
}
