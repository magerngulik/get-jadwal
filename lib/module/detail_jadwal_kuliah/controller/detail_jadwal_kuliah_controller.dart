import 'package:fhe_template/utils/network_manager.dart';
import 'package:flutter/material.dart';
import '../../../core.dart';

class DetailJadwalKuliahController extends State<DetailJadwalKuliahView>
    implements MvcController {
  static late DetailJadwalKuliahController instance;
  late DetailJadwalKuliahView view;
  var mataKuliah = TextEditingController();
  Map datalogin = CheckInController.instance.loginData;
  late String dataEmail;
  bool isLoadingDetail = false;
  var network = NetworkManager();
  List<dynamic> dataScadule = [];
  String daysSelected = JadwalKuliahController.instance.daysPush;

  getDetailScadule(String email) async {
    setState(() {
      isLoadingDetail = true;
    });
    await cekDays(daysSelected);
    dataScadule = await network.getDetailJadwal(email: email, day: daysSelected)
        as List<dynamic>;
    setState(() {
      isLoadingDetail = false;
    });
  }

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

  cardItemDelete(int id) async {
    isLoadingDetail = true;
    print(isLoadingDetail);
    network.deleteSchedule(dataEmail, id.toString());
    Future.delayed(
      const Duration(seconds: 2),
      () {
        dataScadule.clear();
        getDetailScadule(dataEmail);
        JadwalKuliahController.instance.getJadwal(dataEmail);
        JadwalKuliahController.instance.getDetailScadule(dataEmail);
        JadwalKuliahController.instance.setState(() {});
        Navigator.pop(context);
        setState(() {});
      },
    );
    JadwalKuliahController.instance.setState(() {});
    isLoadingDetail = false;
    setState(() {});
  }

  @override
  void initState() {
    instance = this;
    super.initState();
    dataEmail = datalogin['data']['email'];
    getDetailScadule(dataEmail);
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
