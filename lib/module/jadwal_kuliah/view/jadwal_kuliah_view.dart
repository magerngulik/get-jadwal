import 'package:fhe_template/module/jadwal_kuliah/widget/input_data_jadwal_kuliah.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:fhe_template/core.dart';

class JadwalKuliahView extends StatefulWidget {
  const JadwalKuliahView({Key? key}) : super(key: key);

  Widget build(context, JadwalKuliahController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 15,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                            return const AlertDialog(
                                backgroundColor: Colors.transparent,
                                actions: [InputDataJadwalKuliah()]);
                          },
                        );
                        controller.setState(() {});
                      },
                      child: Text(
                        "+ Buat Jadwal Kuliah",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
              (controller.isLoading == true)
                  ? const CircularProgressIndicator()
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(controller.indoDate.length,
                              (index) {
                            var item = controller.indoDate[index];
                            var dataHari = controller.cekDays1(item);
                            var totalHariPerdays = controller.data[dataHari];

                            return InkWell(
                              onTap: () {
                                controller.daysPush = item;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailJadwalKuliahView(
                                            days: item,
                                          )),
                                );
                              },
                              child: JadwalPelajaran(
                                hari: item,
                                jumlahMataKuliah: totalHariPerdays,
                              ),
                            );
                          })),
                    ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.dataDate.length, (index) {
                    var itemDate = controller.dataDate[index];
                    List detailJadwal = [];
                    switch (index) {
                      case 0:
                        detailJadwal = controller.seninDetail;
                        break;
                      case 1:
                        detailJadwal = controller.selasaDetail;
                        break;
                      case 2:
                        detailJadwal = controller.rabuDetail;

                        break;
                      case 3:
                        detailJadwal = controller.kamisDetail;

                        break;
                      case 4:
                        detailJadwal = controller.jumatDetail;
                        break;
                    }
                    return XdetailJadwal(data: detailJadwal);
                  }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  State<JadwalKuliahView> createState() => JadwalKuliahController();
}
