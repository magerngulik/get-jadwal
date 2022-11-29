import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:fhe_template/core.dart';

class CheckInView extends StatefulWidget {
  const CheckInView({Key? key}) : super(key: key);

  Widget build(context, CheckInController controller) {
    controller.view = this;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xff3A0B48),
        centerTitle: true,
        title: Text(
          "Get Jadwal",
          style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700),
        ),
        actions: const [],
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
              height: 334,
              width: 491,
              margin: const EdgeInsets.only(
                top: 45.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 42.0,
                  ),
                  Text(
                    "Check in",
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 53.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 65.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 65),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        autofocus: true,
                        controller: controller.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email tidak boleh kosong";
                          } else if (EmailValidator.validate(value) == false) {
                            return "Format email salah";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: "Masukan email anda",
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
                        onChanged: (value) {
                          controller.cekStatus();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22.0,
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.checkin();
                      } else {
                        controller.status = false;
                        // controller.update();
                      }
                    },
                    child: Container(
                      width: 361,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (controller.email.text.isEmpty &&
                                controller.status == false)
                            ? const Color(0xffD9019C).withOpacity(0.2)
                            : const Color(0xffD9019C),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            47.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Mulai Sesi",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }

  @override
  State<CheckInView> createState() => CheckInController();
}
