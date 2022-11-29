import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

class DialogDeleteData extends StatefulWidget {
  final item;
  const DialogDeleteData({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DialogDeleteData> createState() => _DialogDeleteDataState();
}

class _DialogDeleteDataState extends State<DialogDeleteData> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: Colors.transparent, actions: [
      Container(
        height: 343.0,
        width: 425,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.0,
            ),
          ),
        ),
        child: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    height: 88.0,
                    width: 88,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/icon_delete.png",
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          16.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    "Hapus Mata Kuliah",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: const Color(0xff100720),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    width: 380,
                    child: Text(
                      "Apakah anda yakin untuk menghapus mata kuliah ${widget.item['title']}?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: const Color(0xff888888),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 34.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 122,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF4F4F4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(47),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Batal",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff888888),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 17.0,
                      ),
                      SizedBox(
                        width: 122,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffED4C5C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(47),
                            ),
                          ),
                          onPressed: () {
                            isLoading = true;
                            setState(() {});
                            DetailJadwalKuliahController.instance
                                .cardItemDelete(widget.item['id']);
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                isLoading = false;
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            "Hapus",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    ]);
  }
}
