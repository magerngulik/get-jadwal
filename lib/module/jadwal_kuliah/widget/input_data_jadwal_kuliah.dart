import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core.dart';
import '../../../utils/network_manager.dart';

class InputDataJadwalKuliah extends StatefulWidget {
  final String? label;

  const InputDataJadwalKuliah({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  State<InputDataJadwalKuliah> createState() => _InputDataJadwalKuliahState();
}

class _InputDataJadwalKuliahState extends State<InputDataJadwalKuliah> {
  List<String> list = <String>['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  final formKey = GlobalKey<FormState>();
  var mataKuliah = TextEditingController();
  String daysSelected = "";
  String daysPush = "";
  final network = NetworkManager();
  Map datalogin = CheckInController.instance.loginData;
  late String dataEmail;
  bool isLoading = false;

  cekDays(String days) {
    switch (days) {
      case "Senin":
        daysSelected = 'monday';
        break;
      case "Selasa":
        daysSelected = 'tuesday';
        break;
      case "Rabu":
        daysSelected = 'wednesday';
        break;
      case "Kamis":
        daysSelected = 'thursday';
        break;
      case "Jumat":
        daysSelected = 'friday';
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    dataEmail = datalogin['data']['email'];
  }

  postDataMatakuliah(String title, String days) {
    cekDays(days);

    debugPrint("Data Email: $dataEmail");
    debugPrint("Data title: ${mataKuliah.text}");
    debugPrint("Data Hari: $daysSelected");
    network.addSchedule(dataEmail, title, daysSelected);
    setState(() {
      JadwalKuliahController.instance.data.clear();
      JadwalKuliahController.instance.getJadwal(dataEmail);
      JadwalKuliahController.instance.getDetailScadule(dataEmail);
      JadwalKuliahController.instance.setState(() {});
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.0,
      width: 830,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
      ),
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 35.0,
                ),
                Text(
                  "Buat Jadwal Kuliah",
                  style: GoogleFonts.poppins(
                      color: const Color(0xff100720),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Divider(),
            Row(
              children: [
                const SizedBox(
                  width: 35.0,
                ),
                Text(
                  "Mata Kuliah",
                  style: GoogleFonts.poppins(
                      color: const Color(0xff100720),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(
                autofocus: true,
                controller: mataKuliah,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Matakuliah tidak boleh kosong";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: "Masukan Mata Kuliah",
                  errorStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffD9019C),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffD9019C),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 35.0,
                ),
                Text(
                  "Pilih Hari",
                  style: GoogleFonts.poppins(
                      color: const Color(0xff100720),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: DropdownButtonFormField<String>(
                validator: (value) =>
                    value == null ? 'Silahkan Pilih Hari' : null,
                hint: Text(
                  'Pilih Hari',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                decoration: InputDecoration(
                  errorStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide:
                        BorderSide(width: 2.0, color: Color(0xffE5E5E5)),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide:
                        BorderSide(width: 2.0, color: Color(0xffE5E5E5)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide:
                        BorderSide(width: 2.0, color: Color(0xffE5E5E5)),
                  ),
                ),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  daysSelected = value!;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Divider(),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD9019C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // controller
                        //     .postDataMatakuliah(
                        //         controller
                        //             .mataKuliah
                        //             .text,
                        //         controller.hari);

                        // controller
                        //     .refrestChangeData();

                        // print(mataKuliah.text);

                        postDataMatakuliah(mataKuliah.text, daysSelected);
                      }
                    },
                    child: Text(
                      "Simpan",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 35.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
