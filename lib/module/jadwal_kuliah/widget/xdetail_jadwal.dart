import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XdetailJadwal extends StatefulWidget {
  List data;
  XdetailJadwal({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<XdetailJadwal> createState() => _XdetailJadwalState();
}

class _XdetailJadwalState extends State<XdetailJadwal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 187,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: widget.data.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = widget.data[index];
          return Container(
            height: 56.0,
            width: 166,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
              color: Color(0xffF8F8F8),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  12.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                "${item['title']}",
                maxLines: 2,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }
}
