import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osar_pasar/models/provinces.dart';
import 'package:osar_pasar/widgets/custom_text_field.dart';

import '../controller/auth/address_controller.dart';
import '../utils/colors.dart';
import 'booking_summary.dart';

class AddressPage extends StatefulWidget {
  AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final addressController = Get.put(AddressController());
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController pickupAddressController = TextEditingController();
  TextEditingController destinationAddressController = TextEditingController();
  List<NepalProvince> province = [];
  NepalProvince? selectedProvince;
  District? selectedDistrict;
  Cities? selectedCities;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddressController().get().then((value) {
      province = value;
    });
  }

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
          "Address",
          style: textTheme.titleLarge!
              .copyWith(fontSize: 16, color: AppColors.textColor),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // TextField(
            //   readOnly: true,
            //   // controller: controller,
            //   onTap: () => c.chooseDate(context, c.selectedDate),
            //   decoration: InputDecoration(
            //     contentPadding: const EdgeInsets.all(14),
            //     hintText: "Select date",
            //     hintStyle: const TextStyle(
            //       fontSize: 15,
            //       fontWeight: FontWeight.w400,
            //     ),
            //     suffixIcon: const Icon(Icons.calendar_month),
            //     border: InputBorder.none,
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(
            //         width: 1,
            //       ),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(
            //         width: 1,
            //       ),
            //     ),
            //     disabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(
            //         width: 1,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "Select date",
              readOnly: true,
              controller: dateController,
              onTap: () async {
                DateTime now = DateTime.now();

                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: now,
                  lastDate: DateTime(now.year + 1),
                ).then((value) {
                  if (value != null) {
                    dateController.text = value.toString().split(" ")[0];
                    setState(() {});
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "Select time",
              readOnly: true,
              controller: timeController,
              onTap: () async {
                await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().hour))
                    .then((value) {
                  if (value != null) {
                    timeController.text = value.format(context);
                    setState(() {});
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "Select pickup address",
              controller: pickupAddressController,
              onTap: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Container(
                          padding: const EdgeInsets.only(left: 36, right: 36),
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                height: 55,
                                child: DropdownButtonFormField(
                                  icon: const Visibility(
                                      visible: false,
                                      child: Icon(Icons.arrow_downward)),
                                  alignment: AlignmentDirectional.bottomCenter,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      border: const OutlineInputBorder(
                                        gapPadding: 1,
                                        borderSide: BorderSide(
                                            color: Color(0xfffD9D9D9),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      suffix: const Text(""),
                                      suffixIcon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "Select Province",
                                      fillColor: Colors.white),
                                  onChanged: (pro) {
                                    selectedProvince = pro;
                                    setState(() {});
                                  },
                                  // itemHeight: 48,
                                  items: province
                                      .map(
                                        (cityTitle) => DropdownMenuItem(
                                          value: cityTitle,
                                          child: SizedBox(
                                              height: 30,
                                              child: Text("${cityTitle.name}")),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              // if (selectedProvice != null)
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: DropdownButtonFormField(
                                  icon: const Visibility(
                                      visible: false,
                                      child: Icon(Icons.arrow_downward)),
                                  alignment: AlignmentDirectional.bottomCenter,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      border: const OutlineInputBorder(
                                        gapPadding: 1,
                                        borderSide: BorderSide(
                                            color: Color(0xfffD9D9D9),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                      suffix: const Text(""),
                                      suffixIcon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "Select District",
                                      fillColor: Colors.white),
                                  onChanged: (pro) {
                                    selectedDistrict = pro;
                                    setState(() {});
                                  },
                                  items: (selectedProvince?.districts ?? [])
                                      .map(
                                        (cityTitle) => DropdownMenuItem(
                                          value: cityTitle,
                                          child: Text(cityTitle.name),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              // if ((selectedDistrict?.cities ?? []).isNotEmpty)
                              // Container(
                              //   margin: EdgeInsets.only(top: 15),
                              //   child: DropdownButtonFormField(
                              //     icon: Visibility(
                              //         visible: false,
                              //         child: Icon(Icons.arrow_downward)),
                              //     alignment: AlignmentDirectional.bottomCenter,
                              //     decoration: InputDecoration(
                              //         contentPadding: EdgeInsets.symmetric(
                              //             vertical: 5, horizontal: 10),
                              //         border: OutlineInputBorder(
                              //           gapPadding: 1,
                              //           borderSide: BorderSide(
                              //               color: Color(0xfffD9D9D9),
                              //               width: 2),
                              //           borderRadius: BorderRadius.all(
                              //             Radius.circular(8.0),
                              //           ),
                              //         ),
                              //         suffix: Text(""),
                              //         suffixIcon:
                              //             Icon(Icons.keyboard_arrow_down),
                              //         filled: true,
                              //         hintStyle:
                              //             TextStyle(color: Colors.grey[800]),
                              //         hintText: " Select Cities",
                              //         fillColor: Colors.white),
                              //     onChanged: (pro) {
                              //       selectedCities = pro;
                              //
                              //       setState(() {});
                              //     },
                              //     items: (selectedDistrict?.cities ?? [])
                              //         .map(
                              //           (cityTitle) => DropdownMenuItem(
                              //             value: cityTitle,
                              //             child: Text(cityTitle.name),
                              //           ),
                              //         )
                              //         .toList(),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                hint: 'Enter your city name',
                                autoFocus: false,
                                controller: cityController,
                                // textInputType: TextInputType.multiline,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                hint: 'Enter your street address',
                                autoFocus: false,
                                controller: streetAddressController,
                                // textInputType: TextInputType.multiline,
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff00183F),
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                onPressed: (() {
                                  pickupAddressController.text =
                                      "${selectedProvince?.name ?? ""},${selectedDistrict?.name ?? ""},${cityController.text}, ${streetAddressController.text}";
                                  streetAddressController.text = "";
                                  Get.back();
                                }),
                                child: const Text("Next"),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        );
                      });
                    });
              },
              readOnly: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                readOnly: true,
                controller: destinationAddressController,
                hint: "Select destination address",
                onTap: () {
                  showModalBottomSheet(
                      useSafeArea: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Container(
                            padding: const EdgeInsets.only(left: 36, right: 36),
                            height: MediaQuery.of(context).size.height * 0.8,
                            // height: MediaQuery.of(context).size.height * 0.6,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 55,
                                  child: DropdownButtonFormField(
                                    icon: const Visibility(
                                        visible: false,
                                        child: Icon(Icons.arrow_downward)),
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                        border: const OutlineInputBorder(
                                          gapPadding: 1,
                                          borderSide: BorderSide(
                                              color: Color(0xfffD9D9D9),
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                        suffix: const Text(""),
                                        suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        hintText: "Select Province",
                                        fillColor: Colors.white),
                                    onChanged: (pro) {
                                      selectedProvince = pro;
                                      setState(() {});
                                    },
                                    // itemHeight: 48,
                                    items: province
                                        .map(
                                          (cityTitle) => DropdownMenuItem(
                                            value: cityTitle,
                                            child: SizedBox(
                                                height: 30,
                                                child:
                                                    Text("${cityTitle.name}")),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                // if (selectedProvice != null)
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: DropdownButtonFormField(
                                    icon: const Visibility(
                                        visible: false,
                                        child: Icon(Icons.arrow_downward)),
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                        border: const OutlineInputBorder(
                                          gapPadding: 1,
                                          borderSide: BorderSide(
                                              color: Color(0xfffD9D9D9),
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                        suffix: const Text(""),
                                        suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        hintText: "Select District",
                                        fillColor: Colors.white),
                                    onChanged: (pro) {
                                      selectedDistrict = pro;
                                      setState(() {});
                                    },
                                    items: (selectedProvince?.districts ?? [])
                                        .map(
                                          (cityTitle) => DropdownMenuItem(
                                            value: cityTitle,
                                            child: Text(cityTitle.name),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                // if ((selectedDistrict?.cities ?? []).isNotEmpty)
                                // Container(
                                //   margin: const EdgeInsets.only(top: 15),
                                //   child: DropdownButtonFormField(
                                //     icon: const Visibility(
                                //         visible: false,
                                //         child: Icon(Icons.arrow_downward)),
                                //     alignment:
                                //         AlignmentDirectional.bottomCenter,
                                //     decoration: InputDecoration(
                                //         contentPadding:
                                //             const EdgeInsets.symmetric(
                                //                 vertical: 5, horizontal: 10),
                                //         border: const OutlineInputBorder(
                                //           gapPadding: 1,
                                //           borderSide: BorderSide(
                                //               color: Color(0xfffD9D9D9),
                                //               width: 2),
                                //           borderRadius: BorderRadius.all(
                                //             Radius.circular(8.0),
                                //           ),
                                //         ),
                                //         suffix: const Text(""),
                                //         suffixIcon: const Icon(
                                //             Icons.keyboard_arrow_down),
                                //         filled: true,
                                //         hintStyle:
                                //             TextStyle(color: Colors.grey[800]),
                                //         hintText: " Select Cities",
                                //         fillColor: Colors.white),
                                //     onChanged: (pro) {
                                //       selectedCities = pro;

                                //       setState(() {});
                                //     },
                                //     items: (selectedDistrict?.cities ?? [])
                                //         .map(
                                //           (cityTitle) => DropdownMenuItem(
                                //             value: cityTitle,
                                //             child: Text(cityTitle.name),
                                //           ),
                                //         )
                                //         .toList(),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  hint: 'Enter your city name',
                                  autoFocus: false,
                                  controller: cityController,
                                  // textInputType: TextInputType.multiline,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  hint: 'Enter your street address',
                                  autoFocus: false,
                                  controller: streetAddressController,
                                  // textInputType: TextInputType.multiline,
                                ),
                                const SizedBox(
                                  height: 38,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff00183F),
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  onPressed: (() {
                                    destinationAddressController.text =
                                        "${selectedProvince?.name ?? ""},${selectedDistrict?.name ?? ""},${cityController.text}, ${streetAddressController.text}";
                                    streetAddressController.text = "";
                                    Get.back();
                                  }),
                                  child: const Text("Next"),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          );
                        });
                      });
                }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff00183F),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: (() => Get.to(() => const BookingSummary())),
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
