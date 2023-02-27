import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osar_pasar/widgets/custom_text_field.dart';

import '../models/category.dart';
import '../repo/category_repo.dart';

class ItemController extends GetxController {
  RxList<CategoryItem> category = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    getAllCatgegory();
    super.onInit();
  }

  getAllCatgegory() async {
    log("yhea samma aayo ");
    loading.value = true;
    await CategoryRepo.getCategory(onSuccess: (categories) {
      loading.value = false;
      category.addAll(categories);
    }, onError: (message) {
      loading.value = false;
    });
  }

  showCategory() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(45.0),
        ),
      ),
      context: Get.context!,
      builder: ((context) => SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 63,
                  ),
                  const Text("Add Item"),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextField(),
                  const SizedBox(
                    height: 31,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 46, right: 35, left: 35),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: const Color(0xff00183F),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {},
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
