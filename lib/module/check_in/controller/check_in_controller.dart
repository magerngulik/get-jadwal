import 'package:email_validator/email_validator.dart';
import 'package:fhe_template/core.dart';
import 'package:fhe_template/utils/network_manager.dart';
import 'package:flutter/material.dart';

class CheckInController extends State<CheckInView> implements MvcController {
  static late CheckInController instance;
  late CheckInView view;

  final email = TextEditingController();
  final network = NetworkManager();
  bool status = false;
  Map loginData = {};

  Future<void> checkin() async {
    final data = await network.chekin(email.text);
    loginData = data;
    if (loginData['status'] == 'Success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const JadwalKuliahView()),
      );
    }
  }

  cekStatus() {
    if (status == false || email.text.isEmpty) {
      status = true;
      setState(() {});
    }
  }

  testing() {
    var validate = EmailValidator.validate(email.text);
    print(validate);
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
