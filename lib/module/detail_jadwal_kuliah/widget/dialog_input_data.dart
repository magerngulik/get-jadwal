import 'package:fhe_template/utils/network_manager.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../core.dart';

class DialogInputData extends StatefulWidget {
  Map? item;
  DialogInputData({
    this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<DialogInputData> createState() => _DialogInputDataState();
}

class _DialogInputDataState extends State<DialogInputData> {
  final formKey = GlobalKey<FormState>();
  var mataKuliah = TextEditingController();
  String daysSelected = JadwalKuliahController.instance.daysPush;
  String dayConvert = "";
  Map datalogin = CheckInController.instance.loginData;
  late String dataEmail;
  bool editMode = false;
  bool isLoading = false;
  final _network = NetworkManager();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      mataKuliah.text = "${widget.item!['title']}";
      editMode = true;
    }
  }

  cekDays(String days) {
    switch (days) {
      case "Senin":
        dayConvert = 'monday';
        break;
      case "Selasa":
        dayConvert = 'tuesday';
        break;
      case "Rabu":
        dayConvert = 'wednesday';
        break;
      case "Kamis":
        dayConvert = 'thursday';
        break;
      case "Jumat":
        dayConvert = 'friday';
        break;
      default:
    }
  }

  postDataMahasiswa() {
    dataEmail = datalogin['data']['email'];
    cekDays(daysSelected);
    if (editMode) {
      isLoading = true;
      setState(() {});
      _network.updateSchedule(
          email: dataEmail, title: mataKuliah.text, id: widget.item!['id']);
      Future.delayed(
        const Duration(seconds: 2),
        () {
          isLoading = false;
          setState(() {});
          Navigator.pop(context);
          JadwalKuliahController.instance.data.clear();
          JadwalKuliahController.instance.getJadwal(dataEmail);
          DetailJadwalKuliahController.instance.dataScadule.clear();
          DetailJadwalKuliahController.instance.getDetailScadule(dataEmail);
          DetailJadwalKuliahController.instance.setState(() {});
          JadwalKuliahController.instance.setState(() {});
        },
      );
    } else {
      isLoading = true;
      setState(() {});
      _network.addSchedule(dataEmail, mataKuliah.text, dayConvert);
      Future.delayed(
        const Duration(seconds: 2),
        () {
          isLoading = false;
          setState(() {});
          Navigator.pop(context);
          JadwalKuliahController.instance.data.clear();
          JadwalKuliahController.instance.getJadwal(dataEmail);
          JadwalKuliahController.instance.getDetailScadule(dataEmail);
          JadwalKuliahController.instance.setState(() {});
          DetailJadwalKuliahController.instance.dataScadule.clear();
          DetailJadwalKuliahController.instance.getDetailScadule(dataEmail);
          DetailJadwalKuliahController.instance.setState(() {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: Colors.transparent, actions: [
      Container(
        height: 360.0,
        width: 830,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              12.0,
            ),
          ),
        ),
        child: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : ListView(
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
                        (widget.item == null)
                            ? "Tambah Mata Kuliah"
                            : "Edit Mata Kuliah",
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
                    child: Form(
                      key: formKey,
                      child: TextFormField(
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
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 37.5,
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
                              postDataMahasiswa();
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
    ]);
  }
}
