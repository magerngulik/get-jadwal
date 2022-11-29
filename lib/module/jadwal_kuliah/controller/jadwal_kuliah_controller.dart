import 'package:fhe_template/core.dart';
import 'package:flutter/material.dart';

import '../../../utils/network_manager.dart';

class JadwalKuliahController extends State<JadwalKuliahView>
    implements MvcController {
  static late JadwalKuliahController instance;

  String hari = "";
  late JadwalKuliahView view;
  final network = NetworkManager();
  Map datalogin = CheckInController.instance.loginData;
  late String dataEmail;
  bool isLoading = false;
  bool isLoadingDetail = false;
  Map data = {};
  String daysSelected = "";
  String daysPush = "";

  //detail harian
  List<dynamic> seninDetail = [];
  List<dynamic> selasaDetail = [];
  List<dynamic> rabuDetail = [];
  List<dynamic> kamisDetail = [];
  List<dynamic> jumatDetail = [];

  // int? senin;
  // int? selasa;
  // int? rabu;
  // int? kamis;
  // int? jumat;

  List dataDate = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'];
  List indoDate = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  String cekDays1(String days) {
    switch (days) {
      case "Senin":
        daysSelected = 'monday';
        {}
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
    return daysSelected;
  }

  // get resetTextfield {
  //   mataKuliah.text = "";
  // }

  refrestChangeData() {
    data.clear();
    getJadwal(dataEmail);
    setState(() {});
  }

  //get data jadwal hari
  getJadwal(String email) async {
    setState(() {
      isLoading = true;
    });
    final getData = await network.getJadwal(email);
    data = getData as Map;

    setState(() {
      isLoading = false;
    });
  }

  //get data detail jadwal hari
  getDetailScadule(String email) async {
    setState(() {
      isLoadingDetail = true;
    });
    for (var i = 0; i < dataDate.length; i++) {
      var item = dataDate[i];
      final dataDetailJadwal =
          await network.getDetailJadwal(email: email, day: item);
      switch (i) {
        case 0:
          seninDetail = dataDetailJadwal as List<dynamic>;
          break;
        case 1:
          selasaDetail = dataDetailJadwal as List<dynamic>;
          break;
        case 2:
          rabuDetail = dataDetailJadwal as List<dynamic>;
          break;
        case 3:
          kamisDetail = dataDetailJadwal as List<dynamic>;
          break;
        case 4:
          jumatDetail = dataDetailJadwal as List<dynamic>;
          break;

        default:
      }
    }
    setState(() {
      isLoadingDetail = false;
    });
  }

  @override
  void initState() {
    super.initState();
    dataEmail = datalogin['data']['email'];
    instance = this;
    getJadwal(dataEmail);
    getDetailScadule(dataEmail);
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
