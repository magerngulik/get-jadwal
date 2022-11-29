import 'package:fhe_template/module/detail_jadwal_kuliah/widget/dialog_input_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:fhe_template/core.dart';

import '../widget/dialog_delete_data.dart';

class DetailJadwalKuliahView extends StatefulWidget {
  String? days;

  DetailJadwalKuliahView({this.days, Key? key}) : super(key: key);

  Widget build(context, DetailJadwalKuliahController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 124.0,
                decoration: const BoxDecoration(
                  color: Color(0xff3A0B48),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    Text(
                      "GetJadwal",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      width: 365,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD9019C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckInView()),
                          );
                        },
                        child: Text(
                          "Check out | ${controller.dataEmail}",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              // (controller.dataEmail.length > 20) ? 11 : 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: 999,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 32.0,
                              ),
                            ),
                            Text(
                              "$days",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff100720),
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 251,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffD9019C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              ),
                            ),
                            onPressed: () async {
                              await showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return DialogInputData();
                                },
                              );
                            },
                            child: Text(
                              "+ Tambah Kuliah",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 29.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 29.0,
                    ),
                    const Divider(),
                  ],
                ),
              ),
              const SizedBox(
                height: 29.0,
              ),
              SizedBox(
                width: 999.0,
                height: MediaQuery.of(context).size.height,
                child: (controller.dataScadule == [] ||
                        controller.dataScadule.isEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 413,
                            width: 541,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/no_data.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: controller.dataScadule.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = controller.dataScadule[index];

                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Container(
                                  height: 80.0,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        16.0,
                                      ),
                                    ),
                                  ),
                                  child: (controller.isLoadingDetail)
                                      ? const CircularProgressIndicator()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 32.0,
                                            ),
                                            Text(
                                              "${item['title']}",
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xff100720),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    await showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return DialogInputData(
                                                          item: item,
                                                        );
                                                      },
                                                    );

                                                    await controller.update();
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit_outlined,
                                                    size: 24.0,
                                                    color: Color(0xffBBBBBB),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 31.67,
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    bool confirm = false;
                                                    await showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return DialogDeleteData(
                                                            item: item);
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    color: Color(0xffBBBBBB),
                                                    Icons.delete_outline,
                                                    size: 24.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 17.0,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  State<DetailJadwalKuliahView> createState() => DetailJadwalKuliahController();
}
