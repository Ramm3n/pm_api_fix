// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/auth/auth_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/utils/app_colors.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/anggota/input_anggota_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/kepala/kepala_keluarga_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/lokasi/input_lokasi_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/login/login_page.dart';

class KependudukanPage extends StatefulWidget {
  bool? isAdded;
  int? idKepalaKeluarga;
  String? noKK;
  String? namaKepala;
  String? alamat;
  String? rt;
  String? rw;
  String? kodeProv;
  String? kodeKota;
  String? kodeKec;
  String? kodeKel;
  int? lokasiObjek;
  String? idPic;
  KependudukanPage({
    this.isAdded,
    this.idKepalaKeluarga,
    this.noKK,
    this.namaKepala,
    this.alamat,
    this.rt,
    this.rw,
    this.kodeProv,
    this.kodeKota,
    this.kodeKec,
    this.kodeKel,
    this.lokasiObjek,
    this.idPic,
    super.key,
  });

  @override
  State<KependudukanPage> createState() => _KependudukanPageState();
}

class _KependudukanPageState extends State<KependudukanPage> {
  final _key = GlobalKey<ExpandableFabState>();

  bool isAlertDialogShown = false;
  bool isEdited = false;
  String alamatDomisili = "Masukkan Alamat Domisili";
  String selectedOption = 'Option 1';
  late double _lat;
  late double _lng;

  String _regionCode = '';
  List<String> provinsiData = ["Pilih Provinsi"];
  List<String> kabupatenData = ["Pilih Kabupaten/Kota"];
  List<String> kecamatanData = ["Pilih Kecamatan"];
  List<String> kelurahanData = ["Pilih Kelurahan"];

  String provinsiDefault = "Pilih Provinsi";
  String kabupatenDefault = "Pilih Kabupaten/Kota";
  String kecamatanDefault = "Pilih Kecamatan";
  String kelurahanDefault = "Pilih Kelurahan";

  String? selectedProvince = "";
  String? selectedKota = "";
  String? selectedKecamatan = "";
  String? selectedKelurahan = "";
  dynamic receivedDataDomisili = [];

  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _kkController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _domisiliController = TextEditingController();
  TextEditingController _rtController = TextEditingController();
  TextEditingController _rwController = TextEditingController();
  TextEditingController _provController = TextEditingController();
  TextEditingController _kotaController = TextEditingController();
  TextEditingController _kecController = TextEditingController();
  TextEditingController _keltController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;

  var _errorText = 'Harus diisi!';
  var _errorInputKK;
  var _errorInputNama;
  var _errorInputAlamat;
  var _errorInputRT;
  var _errorInputRW;
  var _errorInputProv;
  var _errorInputKab;
  var _errorInputKec;
  var _errorInputKel;
  var _errorInputDomisili;
  var name = "";
  var role = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEdited = widget.isAdded!;
    _kkController.text = widget.noKK ?? "";
    _namaController.text = widget.namaKepala ?? "";
    _alamatController.text = widget.alamat ?? "";
    _rtController.text = widget.rt == 'null' ? "" : widget.rt!;
    _rwController.text = widget.rw == 'null' ? "" : widget.rw!;
    selectedProvince = widget.kodeProv ?? "";
    selectedKota = widget.kodeKota ?? "";
    selectedKecamatan = widget.kodeKec ?? "";
    selectedKelurahan = widget.kodeKel ?? "";
    if (widget.noKK == '' || widget.noKK == null) {
      isEdited = !isEdited;
      print('tambah ${widget.kodeProv} ${widget.kodeKota}');
    } else {
      print('edit');
      getAnggota();
    }

    getLokasiObjek(widget.lokasiObjek.toString());
    getUserData();
    // if (widget.lokasiObjek != null || widget.lokasiObjek != '') {
    //   print(widget.lokasiObjek);
    //   getLokasiObjek(widget.lokasiObjek.toString());
    // }
    // context.read<KependudukanCubit>().getKabupaten('32');
    // context.read<KependudukanCubit>().getWilayah(_regionCode);
    // getProvinsi();
    // getLocation();
  }

  Future getUserData() async {
    final data = await SharedPreferencesUtil.getData();
    setState(() {
      name = data['data']['name'];
      role = data['data']['role'];
    });
    return data;
  }

  Future<void> getLokasiObjek(String idLokasi) async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      context
          .read<LokasiCubit>()
          .getLokasiObject(data['data']['token'], idLokasi);
    }
  }

  Future<void> getAnggota() async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // if (widget.noKK!.isNotEmpty || widget.noKK != '') {
        context
            .read<KependudukanCubit>()
            .postDataKeluarga(data['data']['token'], widget.noKK.toString());
        // }
      });
    }
  }

  Future<void> getProvinsi() async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<ProvinsiCubit>().fetchProvinsi(data['data']['token']);
        if (widget.noKK!.isNotEmpty || widget.noKK != '') {
          context.read<KabupatenCubit>().fetchKabupatenByProvinsiId(
              selectedProvince!, data['data']['token']);
          context.read<KecamatanCubit>().fetchKecamatanByKabupatenId(
              selectedKota!, data['data']['token']);
          context.read<KelurahanCubit>().fetchKelurahanByKecamatanId(
              selectedKecamatan!, data['data']['token']);
        }
      });
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // if (permission == LocationPermission.deniedForever) {
    //   // Izin ditolak, Anda dapat memberi tahu pengguna untuk pergi ke pengaturan dan mengizinkan izin.
    //   openAppSettings();
    // } else
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Izin diberikan, Anda dapat mengambil lokasi.
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _lat = position.latitude;
      _lng = position.longitude;

      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    }
  }

  void _formatInputRTRW(String value, TextEditingController controller) {
    // Jika nilainya antara 1 hingga 9, tambahkan '0' di depan
    if (value.isNotEmpty && int.tryParse(value) != null) {
      int number = int.parse(value);
      if (number > 0 && number < 10) {
        String newText = '0$number';

        controller.value = TextEditingValue(
          text: '$newText',
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (number >= 10) {
        // Biarkan angka 10-99 tetap seperti apa adanya
        controller.value = TextEditingValue(
          text: number.toString(),
          selection: TextSelection.collapsed(offset: number.toString().length),
        );
      } else {
        // Jika input tidak valid (bukan angka), kosongkan input
        controller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final kependudukanCubit = context.read<KependudukanCubit>();
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return false;
        },
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                // bottom: screenHeight * 0.6,
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4FC4CF), Color(0xFFa3e0e5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.05,
                // bottom: screenHeight * 0.7,
                right: 0,
                child: Image.asset(
                  'assets/images/img_bginput.png',
                ),
              ),
              Positioned(
                top: screenHeight * 0.08,
                right: 20,
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.account_circle,
                    //   color: Colors.white,
                    //   size: 30,
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Text(
                      '$name ',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12,
                          decoration:
                              TextDecoration.none, // Menghilangkan underline

                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      child: InkWell(
                        onTap: () async {
                          await SharedPreferencesUtil.removeUser();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.white),
                          child: Center(
                            child: Icon(
                              Icons.logout_outlined,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.15,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DATA KEPENDUDUKAN',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Pastikan data yang dimasukkan\ntelah sesuai dan benar dengan KTP',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: BlocConsumer<KependudukanCubit, KependudukanState>(
                  listener: (context, state) async {
                    if (state is ExpiredTokenInput) {
                      await SharedPreferencesUtil.removeUser();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _dialogExpiredToken(context);
                      });
                      // if (data == null || data.isEmpty) {
                      // } else {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const HomePage()),
                      //   );
                      // }
                      // final data = await SharedPreferencesUtil.getData();
                      // print(data['data']['']);
                      // authCubit.doLogin(data['data'][''], password)
                    }
                    if (state is PostPendudukResponse) {
                      isAlertDialogShown = true;
                      // });
                      // if (FocusScope.of(context).hasFocus) {
                      // Periksa apakah keyboard tidak aktif

                      // if (isAlertDialogShown) {
                      // if (state.isResponse) {
                      // if (isAlertDialogShown) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _dialogInputResponse(context, state.isResponse);
                      });
                      print('${state.isResponse}');
                      // }
                      // } else {
                      //   WidgetsBinding.instance.addPostFrameCallback((_) {
                      //     _dialogInputResponse(context, state.isResponse);
                      //   });
                      // }
                      // }
                      // }
                    }
                  },
                  builder: (context, state) {
                    if (state is KependudukanLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Positioned(
                top: screenHeight * 0.3,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        // autovalidateMode: AutovalidateMode.always,
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        // autovalidateMode: _isSubmitted
                        //     ? AutovalidateMode.always
                        //     : AutovalidateMode.disabled,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Nomor Kartu Keluarga',
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _kkController,
                              enabled:
                                  widget.isAdded! ? widget.isAdded : isEdited,
                              maxLength: 16,
                              validator: (value) {
                                if (_isSubmitted) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus diisi';
                                  }
                                  if (value.length < 16) {
                                    return 'harus 16 digit';
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: "Masukkan Nomor KK",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFB7B7B7)),
                                filled: true,
                                fillColor: Color(0xFFF6F6F6),
                                errorBorder: OutlineInputBorder(
                                  borderSide: _isSubmitted
                                      ? _validateTextField(
                                                  _kkController.text) !=
                                              ''
                                          ? BorderSide.none
                                          : BorderSide(color: Colors.red)
                                      : BorderSide.none,
                                ),
                                suffixIcon: _isSubmitted
                                    ? _validateTextField(_kkController.text) !=
                                            ''
                                        ? null
                                        : Icon(
                                            Icons.error,
                                            color: AppColors.dangerColor,
                                          )
                                    : null,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              onEditingComplete: () async {
                                // final data = await SharedPreferencesUtil.getData();
                                // setState(() {
                                //   kependudukanCubit.postDataKeluarga(
                                //       data['data']['token'], _kkController.text);
                                // });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Nama Kepala Keluarga',
                                style: TextStyle(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              controller: _namaController,
                              autofocus: isEdited,
                              enabled:
                                  widget.isAdded! ? widget.isAdded : isEdited,
                              validator: (value) {
                                if (_isSubmitted) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus diisi';
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Masukkan Nama KK",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFB7B7B7)),
                                filled: true,
                                fillColor: const Color(0xFFF6F6F6),
                                errorBorder: OutlineInputBorder(
                                  borderSide: _isSubmitted
                                      ? _validateTextField(
                                                  _namaController.text) !=
                                              ''
                                          ? BorderSide.none
                                          : BorderSide(color: Colors.red)
                                      : BorderSide.none,
                                ),
                                suffixIcon: _isSubmitted
                                    ? _validateTextField(
                                                _namaController.text) !=
                                            ''
                                        ? null
                                        : Icon(
                                            Icons.error,
                                            color: AppColors.dangerColor,
                                          )
                                    : null,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                isDense: true,
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Alamat (sesuai kartu keluarga)',
                                style: TextStyle(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: _alamatController,
                              maxLines: 4,
                              enabled:
                                  widget.isAdded! ? widget.isAdded : isEdited,
                              validator: (value) {
                                if (_isSubmitted) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus diisi';
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Masukkan Alamat",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFB7B7B7)),
                                filled: true,
                                fillColor: const Color(0xFFF6F6F6),
                                errorBorder: OutlineInputBorder(
                                  borderSide: _isSubmitted
                                      ? _validateTextField(
                                                  _alamatController.text) !=
                                              ''
                                          ? BorderSide.none
                                          : BorderSide(color: Colors.red)
                                      : BorderSide.none,
                                ),
                                suffixIcon: _isSubmitted
                                    ? _validateTextField(
                                                _alamatController.text) !=
                                            ''
                                        ? null
                                        : Icon(
                                            Icons.error,
                                            color: AppColors.dangerColor,
                                          )
                                    : null,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal:
                                        12.0), // Mengatur tinggi dengan contentPadding
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4.0, right: 4.0, top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'RT',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF2E2E2E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: screenWidth * 0.3,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          enabled: widget.isAdded!
                                              ? widget.isAdded
                                              : isEdited,
                                          controller: _rtController,
                                          maxLength: 3,
                                          validator: (value) {
                                            if (_isSubmitted) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Harus diisi';
                                              }
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            _formatInputRTRW(
                                                value, _rtController);
                                          },
                                          decoration: InputDecoration(
                                            hintText: "01",
                                            counterText: '',
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFB7B7B7)),
                                            filled: true,
                                            fillColor: Color(0xFFF6F6F6),
                                            // errorText: _validateTextField(
                                            //     _rtController.text),

                                            errorBorder: OutlineInputBorder(
                                              borderSide: _isSubmitted
                                                  ? _validateTextField(
                                                              _rtController
                                                                  .text) !=
                                                          ''
                                                      ? BorderSide.none
                                                      : BorderSide(
                                                          color: Colors.red)
                                                  : BorderSide.none,
                                            ),
                                            suffixIcon: _isSubmitted
                                                ? _validateTextField(
                                                            _rtController
                                                                .text) !=
                                                        ''
                                                    ? null
                                                    : Icon(
                                                        Icons.error,
                                                        color: AppColors
                                                            .dangerColor,
                                                      )
                                                : null,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.all(12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'RW',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF2E2E2E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: screenWidth * 0.4,
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: TextFormField(
                                          enabled: widget.isAdded!
                                              ? widget.isAdded
                                              : isEdited,
                                          controller: _rwController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          validator: (value) {
                                            if (_isSubmitted) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Harus diisi';
                                              }
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            _formatInputRTRW(
                                                value, _rwController);
                                          },
                                          decoration: InputDecoration(
                                            hintText: "01",
                                            counterText: '',
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFB7B7B7)),
                                            filled: true,
                                            fillColor: Color(0xFFF6F6F6),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: _isSubmitted
                                                  ? _validateTextField(
                                                              _rwController
                                                                  .text) !=
                                                          ''
                                                      ? BorderSide.none
                                                      : BorderSide(
                                                          color: Colors.red)
                                                  : BorderSide.none,
                                            ),
                                            suffixIcon: _isSubmitted
                                                ? _validateTextField(
                                                            _rwController
                                                                .text) !=
                                                        ''
                                                    ? null
                                                    : Icon(
                                                        Icons.error,
                                                        color: AppColors
                                                            .dangerColor,
                                                      )
                                                : null,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.all(12.0),
                                            // contentPadding: EdgeInsets.symmetric(
                                            //     vertical: 16.0, horizontal: 20.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Provinsi',
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            BlocBuilder<ProvinsiCubit, ProvinsiState>(
                              builder: (context, state) {
                                if (state is ProvinsiLoaded) {
                                  // final wilayah = state.provinsiList;
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: Color(0xFFF6F6F6),
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Radius
                                        ),
                                        child: IgnorePointer(
                                          ignoring: widget.isAdded!
                                              ? isEdited
                                              : !isEdited,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: selectedProvince,
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: "",
                                                enabled: widget.isAdded!
                                                    ? widget.isAdded!
                                                    : isEdited,
                                                child: Text("Pilih Provinsi"),
                                              ),
                                              ...state.provinsiList['data']
                                                      ['Wilayah']
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((option) {
                                                return DropdownMenuItem<String>(
                                                  enabled: widget.isAdded!
                                                      ? widget.isAdded!
                                                      : isEdited,
                                                  value: option['KodeProvinsi']
                                                      .toString(),
                                                  child: Text(
                                                    option['Provinsi']
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                            onChanged:
                                                (String? newValue) async {
                                              final user =
                                                  await SharedPreferencesUtil
                                                      .getData();
                                              setState(() {
                                                selectedProvince =
                                                    newValue ?? "";
                                                print(
                                                    'kode prov $selectedProvince');
                                                context
                                                    .read<KabupatenCubit>()
                                                    .fetchKabupatenByProvinsiId(
                                                        selectedProvince!,
                                                        user['data']['token']);
                                                selectedKota = "";
                                                selectedKecamatan = "";
                                                selectedKelurahan = "";
                                              });
                                              // kependudukanCubit.getKabupaten();
                                            },
                                            validator: (value) {
                                              if (_isSubmitted) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Harus diisi';
                                                }
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFF6F6F6),
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.all(12.0),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: _isSubmitted
                                                    ? _validateDropdown(
                                                                selectedProvince!) !=
                                                            ""
                                                        ? BorderSide.none
                                                        : BorderSide(
                                                            color: Colors.red)
                                                    : BorderSide.none,
                                              ),
                                              suffixIcon: _isSubmitted
                                                  ? _validateDropdown(
                                                              selectedProvince!) !=
                                                          ""
                                                      ? null
                                                      : Icon(
                                                          Icons.error,
                                                          color: AppColors
                                                              .dangerColor,
                                                        )
                                                  : null,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            hint: Text(
                                              'Pilih Provinsi',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFFB7B7B7)),
                                            ),
                                            // autovalidateMode: AutovalidateMode
                                            //     .onUserInteraction,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6F6F6),
                                    borderRadius:
                                        BorderRadius.circular(10.0), // Radius
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: provinsiDefault,
                                    items: provinsiData
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? newValue) {
                                      provinsiDefault = newValue!;
                                    },
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Kabupaten/Kota',
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            BlocConsumer<KabupatenCubit, KabupatenState>(
                              listener: (context, state) {
                                setState(() {});
                              },
                              builder: (context, state) {
                                if (state is KabupatenLoaded) {
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: const Color(0xFFF6F6F6),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: IgnorePointer(
                                          ignoring: widget.isAdded!
                                              ? isEdited
                                              : !isEdited,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: selectedKota,
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: "",
                                                enabled: widget.isAdded!
                                                    ? widget.isAdded!
                                                    : isEdited,
                                                child: Text(
                                                    "Pilih Kabupaten/Kota"),
                                              ),
                                              ...state.kabupatenList['data']
                                                      ['Wilayah']
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((option) {
                                                return DropdownMenuItem<String>(
                                                  enabled: widget.isAdded!
                                                      ? widget.isAdded!
                                                      : isEdited,
                                                  value: option['KodeKabupaten']
                                                      .toString(),
                                                  child: Text(
                                                    option['Kabupaten']
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                            onChanged:
                                                (String? newValue) async {
                                              final user =
                                                  await SharedPreferencesUtil
                                                      .getData();
                                              setState(() {
                                                selectedKota = newValue ?? "";
                                                context
                                                    .read<KecamatanCubit>()
                                                    .fetchKecamatanByKabupatenId(
                                                        selectedKota!,
                                                        user['data']['token']);
                                                selectedKecamatan = "";
                                                selectedKelurahan = "";
                                              });
                                            },
                                            validator: (value) {
                                              if (_isSubmitted) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Harus diisi';
                                                }
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFF6F6F6),
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.all(12.0),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: _isSubmitted
                                                    ? _validateDropdown(
                                                                selectedKota!) !=
                                                            ""
                                                        ? BorderSide.none
                                                        : BorderSide(
                                                            color: Colors.red)
                                                    : BorderSide.none,
                                              ),
                                              suffixIcon: _isSubmitted
                                                  ? _validateDropdown(
                                                              selectedKota!) !=
                                                          ""
                                                      ? null
                                                      : Icon(
                                                          Icons.error,
                                                          color: AppColors
                                                              .dangerColor,
                                                        )
                                                  : null,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            hint: Text(
                                              'Pilih Kabupaten/Kota',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFFB7B7B7)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFFF6F6F6),
                                    borderRadius:
                                        BorderRadius.circular(10.0), // Radius
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: kabupatenDefault,
                                    items: kabupatenData
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? newValue) {
                                      kabupatenDefault = newValue!;
                                    },
                                    validator: (value) {
                                      if (_isSubmitted) {
                                        if (value == null || value.isEmpty) {
                                          return 'Harus diisi';
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF6F6F6),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedKota!) !=
                                                    ""
                                                ? BorderSide.none
                                                : BorderSide(color: Colors.red)
                                            : BorderSide.none,
                                      ),
                                      suffixIcon: _isSubmitted
                                          ? _validateDropdown(selectedKota!) !=
                                                  ""
                                              ? null
                                              : Icon(
                                                  Icons.error,
                                                  color: AppColors.dangerColor,
                                                )
                                          : null,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Kecamatan',
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            BlocBuilder<KecamatanCubit, KecamatanState>(
                              builder: (context, state) {
                                if (state is KecamatanLoaded) {
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: const Color(0xFFF6F6F6),
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Radius
                                        ),
                                        child: IgnorePointer(
                                          ignoring: widget.isAdded!
                                              ? isEdited
                                              : !isEdited,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: selectedKecamatan,
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: "",
                                                enabled: widget.isAdded!
                                                    ? widget.isAdded!
                                                    : isEdited,
                                                child: Text("Pilih Kecamatan"),
                                              ),
                                              ...state.kecamatanList['data']
                                                      ['Wilayah']
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((option) {
                                                return DropdownMenuItem<String>(
                                                  enabled: widget.isAdded!
                                                      ? widget.isAdded!
                                                      : isEdited,
                                                  value: option['KodeKecamatan']
                                                      .toString(),
                                                  child: Text(
                                                    option['Kecamatan']
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                            onChanged:
                                                (String? newValue) async {
                                              final user =
                                                  await SharedPreferencesUtil
                                                      .getData();
                                              setState(() {
                                                selectedKecamatan =
                                                    newValue ?? '';
                                                context
                                                    .read<KelurahanCubit>()
                                                    .fetchKelurahanByKecamatanId(
                                                        selectedKecamatan!,
                                                        user['data']['token']);
                                                selectedKelurahan = "";
                                              });
                                            },
                                            validator: (value) {
                                              if (_isSubmitted) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Harus diisi';
                                                }
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFF6F6F6),
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.all(12.0),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: _isSubmitted
                                                    ? _validateDropdown(
                                                                selectedKecamatan!) !=
                                                            ""
                                                        ? BorderSide.none
                                                        : BorderSide(
                                                            color: Colors.red)
                                                    : BorderSide.none,
                                              ),
                                              suffixIcon: _isSubmitted
                                                  ? _validateDropdown(
                                                              selectedKecamatan!) !=
                                                          ""
                                                      ? null
                                                      : Icon(
                                                          Icons.error,
                                                          color: AppColors
                                                              .dangerColor,
                                                        )
                                                  : null,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            hint: Text(
                                              'Pilih Kecamatan',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFFB7B7B7)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFFF6F6F6),
                                    borderRadius:
                                        BorderRadius.circular(10.0), // Radius
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: kecamatanDefault,
                                    items: kecamatanData
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? newValue) {
                                      kecamatanDefault = newValue!;
                                    },
                                    validator: (value) {
                                      if (_isSubmitted) {
                                        if (value == null || value.isEmpty) {
                                          return 'Harus diisi';
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF6F6F6),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedKecamatan!) !=
                                                    ""
                                                ? BorderSide.none
                                                : BorderSide(color: Colors.red)
                                            : BorderSide.none,
                                      ),
                                      suffixIcon: _isSubmitted
                                          ? _validateDropdown(
                                                      selectedKecamatan!) !=
                                                  ""
                                              ? null
                                              : Icon(
                                                  Icons.error,
                                                  color: AppColors.dangerColor,
                                                )
                                          : null,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Kelurahan',
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            BlocBuilder<KelurahanCubit, KelurahanState>(
                              builder: (context, state) {
                                if (state is KelurahanLoaded) {
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: const Color(0xFFF6F6F6),
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Radius
                                        ),
                                        child: IgnorePointer(
                                          ignoring: widget.isAdded!
                                              ? isEdited
                                              : !isEdited,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: selectedKelurahan,
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: "",
                                                enabled: widget.isAdded!
                                                    ? widget.isAdded!
                                                    : isEdited,
                                                child: Text("Pilih Kelurahan"),
                                              ),
                                              ...state.kelurahanList['data']
                                                      ['Wilayah']
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((option) {
                                                return DropdownMenuItem<String>(
                                                  enabled: widget.isAdded!
                                                      ? widget.isAdded!
                                                      : isEdited,
                                                  value: option['KodeKelurahan']
                                                      .toString(),
                                                  child: Text(
                                                    option['Kelurahan']
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ],
                                            onChanged: (String? newValue) {
                                              // Ini harus dynamic
                                              setState(() {
                                                selectedKelurahan =
                                                    newValue ?? '';
                                              });
                                            },
                                            validator: (value) {
                                              if (_isSubmitted) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Harus diisi';
                                                }
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFF6F6F6),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: _isSubmitted
                                                    ? _validateDropdown(
                                                                selectedKelurahan!) !=
                                                            ""
                                                        ? BorderSide.none
                                                        : BorderSide(
                                                            color: Colors.red)
                                                    : BorderSide.none,
                                              ),
                                              suffixIcon: _isSubmitted
                                                  ? _validateDropdown(
                                                              selectedKelurahan!) !=
                                                          ""
                                                      ? null
                                                      : Icon(
                                                          Icons.error,
                                                          color: AppColors
                                                              .dangerColor,
                                                        )
                                                  : null,
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.all(12.0),
                                              border: InputBorder.none,
                                            ),
                                            hint: Text(
                                              'Pilih Kelurahan',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFFB7B7B7)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFFF6F6F6),
                                    borderRadius:
                                        BorderRadius.circular(10.0), // Radius
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: kelurahanDefault,
                                    items: kelurahanData
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? newValue) {
                                      kelurahanDefault = newValue!;
                                    },
                                    validator: (value) {
                                      if (_isSubmitted) {
                                        if (value == null || value.isEmpty) {
                                          return 'Harus diisi';
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF6F6F6),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedKelurahan!) !=
                                                    ""
                                                ? BorderSide.none
                                                : BorderSide(color: Colors.red)
                                            : BorderSide.none,
                                      ),
                                      suffixIcon: _isSubmitted
                                          ? _validateDropdown(
                                                      selectedKelurahan!) !=
                                                  ""
                                              ? null
                                              : Icon(
                                                  Icons.error,
                                                  color: AppColors.dangerColor,
                                                )
                                          : null,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(12.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 4.0,
                                  left: 4.0,
                                  right: 10.0),
                              child: Text(
                                'Alamat Domisili',
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            BlocConsumer<LokasiCubit, LokasiState>(
                              listener: (context, state) {
                                if (state is GetLokasiSuccess) {
                                  setState(() {
                                    print('lokasi2 ${state.data}');
                                  });
                                }
                                if (state is GetLokasiFailure) {
                                  setState(() {
                                    print('lokasi gagal ${state.data}');
                                  });
                                }
                                // if (state is LokasiObjekSuccess) {
                                //   return setState(() {
                                //     // alamatDomisili = state.data['data']['alamat'];
                                //   });
                                // }
                              },
                              builder: (context, state) {
                                if (state is GetLokasiSuccess) {
                                  return InkWell(
                                    onTap: () async {
                                      // if (widget.isAdded!) {
                                      // if (_lat != null && _lng != null) {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InputLokasiPage(
                                            isAdded: widget.isAdded,
                                            idLokasi: state.data['data']['id'],
                                            alamat: state.data['data']
                                                ['alamat'],
                                            kodeProv: selectedProvince,
                                            kodeKab: selectedKota,
                                            kodeKec: selectedKecamatan,
                                            kodeKel: selectedKelurahan,
                                            rt: state.data['data']['rt'],
                                            rw: state.data['data']['rw'],
                                            lat:
                                                "${state.data['data']['latitude']}",
                                            lng:
                                                "${state.data['data']['longitude']}",
                                            identitasObjek: state.data['data']
                                                ['identitas_objek'],
                                          ),
                                        ),
                                      );
                                      if (result != null) {
                                        setState(() {
                                          receivedDataDomisili = result;
                                        });
                                      }
                                      // }
                                      // }
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: 80,
                                        padding: EdgeInsets.only(
                                            top: 10.0, left: 10),
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFF6F6F6),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child:
                                            // receivedDataDomisili.isEmpty
                                            //     ?
                                            Text(
                                          '${state.data['data']['alamat']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColor,
                                          ),
                                        )
                                        // : Text(
                                        //     receivedDataDomisili[1].toString(),
                                        //     style: GoogleFonts.poppins(
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.w500,
                                        //       color: Color(0xFF2E2E2E),
                                        //     ),
                                        //   ),
                                        ),
                                  );
                                }
                                if (state is EditLokasiSuccess) {
                                  return InkWell(
                                    onTap: () async {
                                      // if (widget.isAdded!) {
                                      // if (_lat != null && _lng != null) {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InputLokasiPage(
                                            isAdded: widget.isAdded,
                                            idLokasi: state.data['data']['id'],
                                            alamat: state.data['data']
                                                ['alamat'],
                                            kodeProv: selectedProvince,
                                            kodeKab: selectedKota,
                                            kodeKec: selectedKecamatan,
                                            kodeKel: selectedKelurahan,
                                            rt: state.data['data']['rt'],
                                            rw: state.data['data']['rw'],
                                            lat:
                                                "${state.data['data']['latitude']}",
                                            lng:
                                                "${state.data['data']['longitude']}",
                                            identitasObjek: state.data['data']
                                                ['identitas_objek'],
                                          ),
                                        ),
                                      );
                                      if (result != null) {
                                        setState(() {
                                          receivedDataDomisili = result;
                                          _domisiliController.text =
                                              receivedDataDomisili['alamat'];
                                        });
                                      }
                                      // }
                                      // }
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            top: 10.0, left: 10),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF6F6F6),
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child:
                                            // receivedDataDomisili.isEmpty
                                            //     ?
                                            Text(
                                          '${state.data['data']['alamat']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColor,
                                          ),
                                        )
                                        // : Text(
                                        //     receivedDataDomisili[1].toString(),
                                        //     style: GoogleFonts.poppins(
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.w500,
                                        //       color: Color(0xFF2E2E2E),
                                        //     ),
                                        //   ),
                                        ),
                                  );
                                }
                                return InkWell(
                                  onTap: () async {
                                    // if (widget.isAdded!) {
                                    // if (_lat != null && _lng != null) {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => InputLokasiPage(
                                          isAdded: widget.isAdded,
                                          alamat: _alamatController.text,
                                          kodeProv: selectedProvince,
                                          kodeKab: selectedKota,
                                          kodeKec: selectedKecamatan,
                                          kodeKel: selectedKelurahan,
                                          rt: _rtController.text,
                                          rw: _rwController.text,
                                        ),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        receivedDataDomisili = result;
                                        _domisiliController.text =
                                            receivedDataDomisili['alamat'];
                                      });
                                    }
                                    // }
                                    // }
                                  },
                                  child: AbsorbPointer(
                                    absorbing: true,
                                    // width: double.infinity,
                                    // height: 40,
                                    // padding: EdgeInsets.only(top: 10.0, left: 10),
                                    // decoration: BoxDecoration(
                                    //     color: Color(0xFFF6F6F6),
                                    //     border: Border.all(
                                    //         color: _isSubmitted
                                    //             ? receivedDataDomisili.isEmpty
                                    //                 ? AppColors.dangerColor
                                    //                 : Colors.white
                                    //             : AppColors.white,
                                    //         width: 1,
                                    //         style: BorderStyle.solid),
                                    //     borderRadius: BorderRadius.all(
                                    //         Radius.circular(10))),
                                    child: TextFormField(
                                      controller: _domisiliController,
                                      enabled: widget.isAdded!
                                          ? widget.isAdded
                                          : isEdited,
                                      validator: (value) {
                                        if (_isSubmitted) {
                                          if (value == null || value.isEmpty) {
                                            return 'Harus diisi';
                                          }
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: receivedDataDomisili.isEmpty
                                            ? "Masukkan Alamat Domisili"
                                            : _domisiliController.text,
                                        // : receivedDataDomisili['alamat']
                                        //     .toString(),
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFFB7B7B7)),
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: _isSubmitted
                                              ? _validateTextField(
                                                          _domisiliController
                                                              .text) !=
                                                      ''
                                                  ? BorderSide.none
                                                  : BorderSide(
                                                      color: Colors.red)
                                              : BorderSide.none,
                                        ),
                                        suffixIcon: _isSubmitted
                                            ? _validateTextField(
                                                        _domisiliController
                                                            .text) !=
                                                    ''
                                                ? null
                                                : Icon(
                                                    Icons.error,
                                                    color:
                                                        AppColors.dangerColor,
                                                  )
                                            : null,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(12.0),
                                      ),
                                    ),
                                    // child: Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       receivedDataDomisili.isEmpty
                                    //           ? "Masukkan Alamat Domisili"
                                    //           : receivedDataDomisili['alamat']
                                    //               .toString(),
                                    //       style: GoogleFonts.poppins(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w500,
                                    //         color: Color(0xFFB7B7B7),
                                    //       ),
                                    //     ),
                                    //     Container(
                                    //       margin: EdgeInsets.only(right: 10),
                                    //       child: _isSubmitted
                                    //           ? receivedDataDomisili.isEmpty
                                    //               ? Icon(
                                    //                   Icons.error,
                                    //                   size: 18,
                                    //                   color:
                                    //                       AppColors.dangerColor,
                                    //                 )
                                    //               : null
                                    //           : null,
                                    //     ),
                                    //   ],
                                    // )
                                    // : Text(
                                    //     receivedDataDomisili[1].toString(),
                                    //     style: GoogleFonts.poppins(
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.w500,
                                    //       color: Color(0xFF2E2E2E),
                                    //     ),
                                    //   ),
                                  ),
                                );
                              },
                            ),

                            InkWell(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InputAnggotaPage(
                                      isAdded: true,
                                      noKk: _kkController.text,
                                    ),
                                  ),
                                );

                                if (result != null) {
                                  setState(() {
                                    getAnggota();
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Tambah Anggota Keluarga',
                                      style: TextStyle(
                                          color: Color(0xFF4FC4CF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Center(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        margin: EdgeInsets.only(left: 6.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF4FC4CF),
                                              Color(0xFF4FC4CF)
                                            ], // Ubah warna sesuai keinginan
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white, // Warna ikon
                                          size: 20.0, // Ukuran ikon
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // BlocProvider(create: (context),),
                            BlocConsumer<KependudukanCubit, KependudukanState>(
                                listener: (context, state) async {
                              if (state is ExpiredTokenInput) {
                                await SharedPreferencesUtil.removeUser();
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _dialogExpiredToken(context);
                                });
                              }
                            }, builder: (context, state) {
                              if (state is KependudukanLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is DataFailure) {
                                return Text('');
                              }
                              if (state is KependudukanSuccess) {
                                var anggota = state.data['data']['content'];
                                return widget.noKK != ''
                                    ? anggota != null
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: anggota.length,
                                            itemBuilder: ((context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        final result =
                                                            await Navigator
                                                                .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                InputAnggotaPage(
                                                              isAdded: false,
                                                              idPic:
                                                                  anggota[index]
                                                                      ['pic'],
                                                              idAnggota:
                                                                  anggota[index]
                                                                      ['id'],
                                                              noKk:
                                                                  _kkController
                                                                      .text,
                                                              noNik:
                                                                  anggota[index]
                                                                      ['nik'],
                                                              namaLengkap:
                                                                  anggota[index]
                                                                      ['nama'],
                                                              jk: anggota[index]
                                                                          [
                                                                          'jenis_kelamin']
                                                                      ['id']
                                                                  .toString(),
                                                              tempat: anggota[
                                                                      index][
                                                                  'tempat_lahir'],
                                                              tglLahir: anggota[
                                                                      index][
                                                                  'tanggal_lahir'],
                                                              goldar: anggota[
                                                                          index]
                                                                      [
                                                                      'golongan_darah']['id']
                                                                  .toString(),
                                                              agama: anggota[
                                                                          index]
                                                                      [
                                                                      'agama']['id']
                                                                  .toString(),
                                                              pendidikan: anggota[
                                                                          index]
                                                                      [
                                                                      'pendidikan']['id']
                                                                  .toString(),
                                                              pekerjaan: anggota[
                                                                          index]
                                                                      [
                                                                      'pekerjaan']['id']
                                                                  .toString(),
                                                              pernikahan: anggota[
                                                                          index]
                                                                      [
                                                                      'status_pernikahan']['id']
                                                                  .toString(),
                                                              hubungan: anggota[
                                                                          index]
                                                                      [
                                                                      'status_hubungan']['id']
                                                                  .toString(),
                                                              warga: anggota[
                                                                          index]
                                                                      [
                                                                      'kewarganegaraan']['id']
                                                                  .toString(),
                                                              ayah: anggota[
                                                                      index]
                                                                  ['nama_ayah'],
                                                              ibu: anggota[
                                                                      index]
                                                                  ['nama_ibu'],
                                                              yatimpiatu: anggota[
                                                                      index][
                                                                  'yatim_piatu'],
                                                            ),
                                                          ),
                                                        );

                                                        if (result != null) {
                                                          setState(() {
                                                            getAnggota();
                                                          });
                                                        }
                                                      },
                                                      child: SizedBox(
                                                        width:
                                                            screenWidth * 0.7,
                                                        child: Text(
                                                          '• ${anggota[index]['nama']} (${anggota[index]['status_hubungan']['nama']})',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Color(
                                                                0xFF4FC4CF),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // isEdited
                                                    //     ? InkWell(
                                                    //         onTap: () async {
                                                    //           final user =
                                                    //               await SharedPreferencesUtil
                                                    //                   .getData();
                                                    //           kependudukanCubit
                                                    //               .deleteAnggotaKeluarga(
                                                    //             user['data']['token'],
                                                    //             state.data['data'][
                                                    //                     'AnggotaKeluarga']
                                                    //                     [index]['id']
                                                    //                 .toString(),
                                                    //           );
                                                    //         },
                                                    //         child: SizedBox(
                                                    //           width:
                                                    //               screenWidth * 0.1,
                                                    //           child: const Icon(
                                                    //             Icons.close,
                                                    //             size: 20,
                                                    //             color: AppColors
                                                    //                 .textColor,
                                                    //           ),
                                                    //         ),
                                                    //       )
                                                    //     : Container()
                                                  ],
                                                ),
                                              );
                                            }),
                                          )
                                        : Text('')
                                    : SizedBox.shrink();
                              }
                              return Text('');
                            }),
                            SizedBox(height: 80),
                            // widget.isAdded!
                            //     ? InkWell(
                            //         onTap: () async {
                            //           setState(() {
                            //             _isSubmitted = true;
                            //           });
                            //           String lokasi =
                            //               _lokasiController.text.trim();
                            //           String kk = _kkController.text.trim();
                            //           String nama = _namaController.text.trim();
                            //           String alamat =
                            //               _alamatController.text.trim();
                            //           String rt = _rtController.text.trim();
                            //           String rw = _rwController.text.trim();
                            //           String kel = _keltController.text.trim();
                            //           String kec = _kecController.text.trim();
                            //           String prov = _provController.text.trim();
                            //           final data =
                            //               await SharedPreferencesUtil.getData();
                            //           // if (lokasi.isNotEmpty ||
                            //           //     kk.isNotEmpty ||
                            //           //     alamat.isNotEmpty ||
                            //           //     kel.isNotEmpty ||
                            //           //     kec.isNotEmpty ||
                            //           //     prov.isNotEmpty) {
                            //           // } else {}
                            //           if (_formKey.currentState!.validate()) {
                            //             // _dialogDelete(context, kependudukanCubit);
                            //             // print(
                            //             //     'ada ${_formKey.currentState?.validate()}');
                            //             kependudukanCubit.postKepalaKeluarga(
                            //                 data['data']['token'],
                            //                 kk,
                            //                 nama,
                            //                 '$alamat',
                            //                 '$rt',
                            //                 '$rw',
                            //                 selectedKelurahan.toString(),
                            //                 selectedKecamatan.toString(),
                            //                 selectedKota.toString(),
                            //                 selectedProvince.toString(),
                            //                 receivedDataDomisili['id']
                            //                     .toString());
                            //           } else {
                            //             print(
                            //                 'kosong ${_formKey.currentState?.validate()}');
                            //           }
                            //         },
                            //         child: Container(
                            //           width: MediaQuery.of(context).size.width,
                            //           height: 40,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(45.0),
                            //             gradient: const LinearGradient(
                            //               colors: [
                            //                 Color(0xFF4FC4CF),
                            //                 Color(0xFF4FC4CF)
                            //               ],
                            //               begin: Alignment.topCenter,
                            //               end: Alignment.bottomCenter,
                            //             ),
                            //           ),
                            //           child: const Center(
                            //               child: Text(
                            //             'SUBMIT',
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.bold),
                            //           )),
                            //         ),
                            //       )
                            //     : isEdited
                            //         ? InkWell(
                            //             onTap: () async {
                            //               final data = await SharedPreferencesUtil
                            //                   .getData();
                            //               setState(() {
                            //                 kependudukanCubit.editKepalaKeluarga(
                            //                   data['data']['token'],
                            //                   widget.idKepalaKeluarga.toString(),
                            //                   _kkController.text,
                            //                   _namaController.text,
                            //                   '${_alamatController.text}',
                            //                   _rtController.text,
                            //                   _rtController.text,
                            //                   selectedKelurahan.toString(),
                            //                   selectedKecamatan.toString(),
                            //                   selectedKota.toString(),
                            //                   selectedProvince.toString(),
                            //                   widget.lokasiObjek.toString(),
                            //                   widget.idPic ?? '',
                            //                 );
                            //               });
                            //             },
                            //             child: Container(
                            //               width:
                            //                   MediaQuery.of(context).size.width,
                            //               height: 40,
                            //               decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(45.0),
                            //                 gradient: const LinearGradient(
                            //                   colors: [
                            //                     Color(0xFF4FC4CF),
                            //                     Color(0xFF4FC4CF)
                            //                   ], // Ubah warna sesuai keinginan
                            //                   begin: Alignment.topCenter,
                            //                   end: Alignment.bottomCenter,
                            //                 ),
                            //               ),
                            //               child: const Center(
                            //                   child: Text(
                            //                 'SUBMIT',
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontSize: 16,
                            //                     fontWeight: FontWeight.bold),
                            //               )),
                            //             ),
                            //           )
                            //         : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(
            left: 16.0, top: 10.0, right: 16.0, bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFe5e5e5),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                setState(() {
                  _isSubmitted = true;
                });
                String lokasi = _lokasiController.text.trim();
                String kk = _kkController.text.trim();
                String nama = _namaController.text.trim();
                String alamat = _alamatController.text.trim();
                String rt = _rtController.text.trim();
                String rw = _rwController.text.trim();
                String kel = _keltController.text.trim();
                String kec = _kecController.text.trim();
                String prov = _provController.text.trim();
                final data = await SharedPreferencesUtil.getData();
                if (_formKey.currentState!.validate()) {
                  if (widget.isAdded!) {
                    kependudukanCubit.postKepalaKeluarga(
                        data['data']['token'],
                        kk,
                        nama,
                        '$alamat',
                        '$rt',
                        '$rw',
                        selectedKelurahan.toString(),
                        selectedKecamatan.toString(),
                        selectedKota.toString(),
                        selectedProvince.toString(),
                        receivedDataDomisili['id'].toString());
                  } else if (isEdited) {
                    setState(() {
                      kependudukanCubit.editKepalaKeluarga(
                        data['data']['token'],
                        widget.idKepalaKeluarga.toString(),
                        _kkController.text,
                        _namaController.text,
                        '${_alamatController.text}',
                        _rtController.text,
                        _rtController.text,
                        selectedKelurahan.toString(),
                        selectedKecamatan.toString(),
                        selectedKota.toString(),
                        selectedProvince.toString(),
                        widget.lokasiObjek.toString(),
                        widget.idPic ?? '',
                      );
                    });
                  }
                } else {
                  print('kosong ${_formKey.currentState?.validate()}');
                }
              },
              child: Container(
                width: widget.isAdded! ? screenWidth * 0.9 : screenWidth * 0.7,
                height: 40,
                decoration: BoxDecoration(
                    color: widget.isAdded!
                        ? AppColors.primaryColor
                        : isEdited
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFe5e5e5),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                        spreadRadius: 0.5,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: GoogleFonts.poppins(
                        color: widget.isAdded!
                            ? AppColors.white
                            : isEdited
                                ? AppColors.white
                                : Colors.grey.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            widget.isAdded!
                ? SizedBox()
                : Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFe5e5e5),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0.5,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                                screenWidth * 0.95, screenHeight * 0.79, 0, 0),
                            color: Colors.transparent,
                            shadowColor: Colors.transparent,
                            constraints: const BoxConstraints.expand(
                                width: 80, height: 110),
                            items: [
                              PopupMenuItem<String>(
                                value: 'option1',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin:
                                          EdgeInsets.only(bottom: 0, right: 4),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF6BCAFF),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFe5e5e5),
                                            blurRadius: 10,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0.5,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    isEdited = !isEdited;
                                  });
                                },
                              ),
                              PopupMenuItem<String>(
                                value: 'option2',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin:
                                          EdgeInsets.only(bottom: 0, right: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.dangerColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFe5e5e5),
                                            blurRadius: 10,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0.5,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  final user =
                                      await SharedPreferencesUtil.getData();
                                  setState(() {
                                    // kependudukanCubit.deleteKepalaKeluarga(
                                    //     user['data']['token'],
                                    //     widget.idKepalaKeluarga.toString());
                                  });
                                  _dialogDelete(context, kependudukanCubit);
                                  // Navigator.pop(context, true);
                                },
                              ),
                            ]);
                      },

                      // },
                      child: Icon(Icons.menu, color: AppColors.primaryColor),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _dialogDelete(
      BuildContext context, KependudukanCubit kependudukanCubit) {
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          // title: Text(
          //   'Error',
          //   textAlign: TextAlign.center,
          // ),
          content: SizedBox(
            height: height * 0.2,
            child: Column(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.amber,
                  size: 80,
                ),
                Text(
                  'Pemberitahuan',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Apakah anda yakin ingin menghapus data tersebut ?',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal',
                style: TextStyle(color: AppColors.textColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                // isAlertDialogShown = false;
                // Menutup AlertDialog
                // Navigator.of(context, rootNavigator: true).pop();
                final user = await SharedPreferencesUtil.getData();
                setState(() {
                  kependudukanCubit.deleteKepalaKeluarga(user['data']['token'],
                      widget.idKepalaKeluarga.toString());
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop(true);
                // Navigator.pushReplacement(
                //   // Ini adalah Navigator yang digunakan untuk merefresh halaman pertama
                //   context,
                //   MaterialPageRoute(builder: (context) => KepalaKeluargaPage()),
                // );
                // Navigator.pop(context, true);
              },
              child: Text(
                'Hapus',
                style: TextStyle(color: AppColors.dangerColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _dialogInputResponse(BuildContext context, bool status) {
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          // title: Text(
          //   'Error',
          //   textAlign: TextAlign.center,
          // ),
          content: SizedBox(
            height: height * 0.2,
            child: Column(
              children: [
                Icon(
                  status ? Icons.check_circle : Icons.warning_rounded,
                  color: status ? Colors.green : Colors.amber,
                  size: 80,
                ),
                Text(
                  status ? ' Berhasil menyimpan data' : 'Gagal menyimpan data',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  status
                      ? 'Data telah berhasil disimpan'
                      : 'Periksa kembali data yang dimasukkan, pastikan data telah sesuai dan benar atau data sudah tersimpan',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                isAlertDialogShown = false;
                if (status) {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _dialogExpiredToken(
    BuildContext context,
  ) {
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          // title: Text(
          //   'Error',
          //   textAlign: TextAlign.center,
          // ),
          content: SizedBox(
            height: height * 0.2,
            child: Column(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.amber,
                  size: 80,
                ),
                Text(
                  'Pemberitahuan',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Session anda telah berakhir, harap login kembali',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // isAlertDialogShown = false;
                // Menutup AlertDialog
                Navigator.of(context, rootNavigator: true).pop();

                // Melakukan pushReplacement
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage()), // Gantilah dengan halaman yang sesuai
                  (route) =>
                      false, // Callback untuk menutup semua halaman saat ini
                );
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _dialogNotifInput(BuildContext context, kk, namaKK, alamat, rt, rw, prov,
      kab, kec, kel, domisili) {
    var height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          // title: Text(
          //   'Error',
          //   textAlign: TextAlign.center,
          // ),
          content: SizedBox(
            height: height * 0.2,
            child: Column(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.amber,
                  size: 80,
                ),
                Text(
                  'Pemberitahuan',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Session anda telah berakhir, harap login kembali',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // isAlertDialogShown = false;
                // Menutup AlertDialog
                Navigator.of(context, rootNavigator: true).pop();

                // Melakukan pushReplacement
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage()), // Gantilah dengan halaman yang sesuai
                  (route) =>
                      false, // Callback untuk menutup semua halaman saat ini
                );
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String? _validateTextField(String value) {
    if (value.isEmpty) {
      return '';
    }
    // Logika validasi kustom lainnya
    // ...

    // Jika validasi berhasil, kembalikan null
    return null;
  }

  String? _validateDropdown(String value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    // Logika validasi kustom lainnya
    // ...

    // Jika validasi berhasil, kembalikan null
    return null;
  }
}
