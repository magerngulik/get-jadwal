import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JadwalPelajaran extends StatelessWidget {
  String hari;
  int jumlahMataKuliah;

  JadwalPelajaran({
    required this.hari,
    required this.jumlahMataKuliah,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Container(
            width: 187,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  12.0,
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    hari,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    (jumlahMataKuliah == 0)
                        ? "Belum ada matakuliah"
                        : "$jumlahMataKuliah Mata Kuliah",
                    style: GoogleFonts.poppins(
                        color: (jumlahMataKuliah == 0)
                            ? const Color(0xffBBBBBB)
                            : const Color(0xffD9019C),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
      ],
    );
  }
}
