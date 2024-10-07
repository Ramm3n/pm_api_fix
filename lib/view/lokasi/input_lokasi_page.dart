// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/main.dart';
import 'package:sistem_pendataan_kewilayahan/utils/app_colors.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/login/login_page.dart';

class InputLokasiPage extends StatefulWidget {
  bool? isAdded;
  final int? idLokasi;
  final String? alamat;
  final String? kodeProv;
  final String? kodeKab;
  final String? kodeKec;
  final String? kodeKel;
  final String? rt;
  final String? rw;
  final String? lat;
  final String? lng;
  final String? identitasObjek;
  InputLokasiPage(
      {this.isAdded,
      this.idLokasi,
      this.alamat,
      this.kodeProv,
      this.kodeKab,
      this.kodeKec,
      this.kodeKel,
      this.rt,
      this.rw,
      this.lat,
      this.lng,
      this.identitasObjek,
      super.key});

  @override
  State<InputLokasiPage> createState() => _InputLokasiPageState();
}

class _InputLokasiPageState extends State<InputLokasiPage> {
  // Map<String, dynamic> selectedJenisObjek = {
  //   "id": "1",
  //   "nmObjek": "Fasilitas tempat tinggal"
  // };
  // double? data1;
  // double? data2;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
  bool isEdited = false;
  late double _lat = 0;
  late double _lng = 0;
  Map<String, dynamic> dataDiterima = {};
  // Map<String, dynamic> dataFromScreen2 = {};

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

  String selectedJenisObjek = "1";
  List<Map<String, dynamic>> jenisObjek = [
    {"id": "1", "nmObjek": "Fasilitas tempat tinggal"},
    // {"id": "2", "nmObjek": "Fasilitas ibadah"},
    // {"id": "3", "nmObjek": "Fasilitas kesehatan"},
    // {"id": "4", "nmObjek": "Fasilitas pendidikan"},
    // {"id": "5", "nmObjek": "Fasilitas rekreasi"},
    // {"id": "6", "nmObjek": "Fasilitas keamanan"},
    // {"id": "7", "nmObjek": "Fasilitas olah raga"},
    // {"id": "8", "nmObjek": "Fasilitas perbelanjaan"},
    // {"id": "9", "nmObjek": "Fasilitas bermain"},
    // {"id": "10", "nmObjek": "Fasilitas transportasi"},
  ];
  String selectedIdentitasObjek = "1";
  List<Map<String, dynamic>> identitasObjek = [
    {"id": "1", "idenObjek": "Rumah tinggal"},
    {"id": "2", "idenObjek": "Rumah susun"},
    {"id": "3", "idenObjek": "Apartemen"},
    // {"id": "4", "idenObjek": "Masjid"},
    // {"id": "5", "idenObjek": "Gereja"},
    // {"id": "6", "idenObjek": "Pura"},
    // {"id": "7", "idenObjek": "Puskesmas"},
    // {"id": "8", "idenObjek": "Rumah sakit"},
    // {"id": "9", "idenObjek": "Pohon"},
    // {"id": "10", "idenObjek": "TPS"},
    // {"id": "11", "idenObjek": "Septictank komunal"},
    // {"id": "12", "idenObjek": "Bank"},
    // {"id": "13", "idenObjek": "Bank sampah"},
    // {"id": "14", "idenObjek": "Koperasi"},
    // {"id": "15", "idenObjek": "Pasar modern"},
    // {"id": "16", "idenObjek": "UMKM"},
    // {"id": "17", "idenObjek": "Klinik"},
    // {"id": "18", "idenObjek": "PAUD"},
    // {"id": "19", "idenObjek": "SD"},
    // {"id": "20", "idenObjek": "SMP"},
    // {"id": "21", "idenObjek": "SMA"},
    // {"id": "22", "idenObjek": "Perguruan Tinggi"},
    // {"id": "23", "idenObjek": "Cafe"},
    // {"id": "24", "idenObjek": "Restoran"},
    // {"id": "25", "idenObjek": "CCTV"},
  ];

  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _identitasController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _rtController = TextEditingController();
  TextEditingController _rwController = TextEditingController();
  TextEditingController _kelController = TextEditingController();
  TextEditingController _kecController = TextEditingController();
  TextEditingController _kotaController = TextEditingController();
  TextEditingController _provController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lngController = TextEditingController();
  TextEditingController _kkController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocation();
    Future.delayed(Duration.zero, () {
      checkAndGetLocation();
    });
    // getPickLocation();
    selectedProvince = widget.kodeProv ?? "";
    selectedKota = widget.kodeKab ?? "";
    selectedKecamatan = widget.kodeKec ?? "";
    selectedKelurahan = widget.kodeKel ?? "";
    _rtController.text = widget.rt ?? "";
    _rwController.text = widget.rw ?? "";
    // _latController.text = widget.lat && widget.lng ?? "";
    // _latController.text = "${widget.lat ?? ''}, ${widget.lng ?? ''}";
    _latController.text =
        "${widget.lat ?? ''}${(widget.lat != null && widget.lng != null) ? ', ' + widget.lng! : ''}";

    selectedIdentitasObjek = widget.identitasObjek ?? "1";
    if (dataDiterima.isEmpty) {
      // _latController.text = '${widget.lat}, ${widget.long}';
      // _lat = widget.lat!;
      // _lng = widget.long!;
      print('kosong $dataDiterima');
    } else {
      double data1 = dataDiterima['latitude'];
      double data2 = dataDiterima['longitude'];

      _lat = data1;
      _lng = data2;
      _latController.text = '${data1}, ${data2}';
      print('ada $dataDiterima');
    }
    _alamatController.text = widget.alamat.toString();
  }

  Future<void> checkAndGetLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      // Minta pengguna untuk mengaktifkan layanan lokasi.
      print("Layanan lokasi tidak diaktifkan.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Izin ditolak, tangani kasus ini sesuai kebutuhan.
        print("Izin lokasi ditolak.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Izin lokasi ditolak secara permanen.
      print("Izin lokasi ditolak secara permanen.");
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Izin diberikan, Anda dapat mengambil lokasi.
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        if (widget.lat == null || widget.lat == "null") {
          _lat = position.latitude;
          _lng = position.longitude;
        } else {
          _lat = double.parse(widget.lat!);
          _lng = double.parse(widget.lng!);
        }
      });

      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Izin ditolak atau ditolak selamanya, beri tahu pengguna untuk pergi ke pengaturan.
      // openAppSettings();
      await Geolocator.requestPermission();
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Izin diberikan, Anda dapat mengambil lokasi.
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // _latController.text = '${position.latitude}, ${position.longitude}';
      // _lngController.text = position.longitude.;
      // print('tt ${widget.lat} ${position.latitude}');
      // if (widget.lat == null || widget.lat == "null") {
      //   print('latt ${widget.lat} ${position.latitude}');
      // } else {
      //   print('lattii ${widget.lat} ${position.latitude}');
      // }
      if (widget.lat == null || widget.lat == "null") {
        _lat = position.latitude;
        _lng = position.longitude;
      } else {
        _lat = double.parse(widget.lat!);
        _lng = double.parse(widget.lng!);
      }
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    }
  }

  void getPickLocation() async {
    dataDiterima = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickMapsPage(
          lat: _lat,
          long: _lng,
        ),
      ),
    );
    if (dataDiterima != null) {
      // Lakukan sesuatu dengan dataDiterima
      double data1 = dataDiterima['latitude'];
      double data2 = dataDiterima['longitude'];
      setState(() {
        _lat = data1;
        _lng = data2;
        _latController.text = '${data1}, ${data2}';
      });
    }
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PickMapsPage(),
    //     settings: RouteSettings(arguments: dataFromScreen2),
    //   ),
    // );
    // if (result != null) {
    //   setState(() {
    //     dataFromScreen2 = result;
    //   });
    // }
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
    final lokasiCubit = context.read<LokasiCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: screenHeight,
        width: screenWidth,
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
              top: screenHeight * 0.1,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat Domisili',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pastikan data yang dimasukkan\ntelah sesuai domisili',
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
              child: BlocConsumer<LokasiCubit, LokasiState>(
                listener: (context, state) async {
                  if (state is ExpiredLokasiInput) {
                    await SharedPreferencesUtil.removeUser();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _dialogExpiredToken(context);
                    });
                  }
                  if (state is LokasiObjekSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _dialogLokasiObjek(context, state.data);
                    });
                  }
                  if (state is EditLokasiSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _dialogLokasiObjek(context, state.data);
                    });
                  }
                  if (state is EditLokasiFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _dialogLokasiObjek(context, state.data);
                    });
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
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Teks di tengah
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.all(10.0),
                          //   child: Text(
                          //     'Lokasi Objek',
                          //     style: GoogleFonts.poppins(
                          //         color: Color(0xFF2E2E2E),
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: const Color(0xFFF6F6F6),
                          //     borderRadius:
                          //         BorderRadius.circular(10.0), // Radius
                          //   ),
                          //   child: DropdownButtonFormField<String>(
                          //     // DropdownButtonFormField<Map<String, dynamic>>(
                          //     value: selectedJenisObjek,
                          //     items:
                          //         jenisObjek.map((Map<String, dynamic> option) {
                          //       return DropdownMenuItem<String>(
                          //         // value: option,
                          //         value: option['id'].toString(),
                          //         child: Text(
                          //           option['nmObjek'].toString(),
                          //           style: GoogleFonts.poppins(
                          //             fontSize: 14,
                          //           ),
                          //         ),
                          //       );
                          //     }).toList(),
                          //     onChanged: (String? newValue) {
                          //       // onChanged: (Map<String, dynamic>? newValue) {
                          //       setState(() {
                          //         selectedJenisObjek =
                          //             newValue ?? ''; // Default jika null
                          //       });
                          //     },
                          //     decoration: InputDecoration(
                          //       isDense: true,
                          //       contentPadding: const EdgeInsets.all(12.0),
                          //       border: InputBorder.none,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Jenis Tempat Tinggal',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              // color: const Color(0xFFF6F6F6),
                              borderRadius:
                                  BorderRadius.circular(10.0), // Radius
                            ),
                            child: IgnorePointer(
                              ignoring: widget.isAdded! ? isEdited : !isEdited,
                              child: DropdownButtonFormField<String>(
                                value: selectedIdentitasObjek,
                                items: identitasObjek
                                    .map((Map<String, dynamic> option) {
                                  return DropdownMenuItem<String>(
                                    value: option['id'].toString(),
                                    child: Text(
                                      option['idenObjek'].toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedIdentitasObjek =
                                        newValue ?? "1"; // Default jika null
                                  });
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
                                                    selectedIdentitasObjek) !=
                                                ""
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  suffixIcon: _isSubmitted
                                      ? _validateDropdown(
                                                  selectedIdentitasObjek) !=
                                              ""
                                          ? null
                                          : Icon(
                                              Icons.error,
                                              color: AppColors.dangerColor,
                                            )
                                      : null,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.all(10.0),
                          //   child: Text(
                          //     'Nama Objek',
                          //     style: GoogleFonts.poppins(
                          //         color: Color(0xFF2E2E2E),
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          // TextField(
                          //   // controller: _textEditingController,
                          //   decoration: InputDecoration(
                          //     hintText: "Input Nama Objek",
                          //     hintStyle: GoogleFonts.poppins(
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w500,
                          //         color: const Color(0xFFB7B7B7)),
                          //     filled: true,
                          //     fillColor: const Color(0xFFF6F6F6),
                          //     border: const OutlineInputBorder(
                          //         borderSide: BorderSide.none,
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(10))),
                          //     isDense: true,
                          //     contentPadding: const EdgeInsets.all(12.0),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Alamat Domisili',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            controller: _alamatController,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
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
                              hintText: "Input Alamat",
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
                                left: 8.0, right: 8.0, top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'RT',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFF2E2E2E),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 100,
                                      child: TextFormField(
                                        controller: _rtController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 3,
                                        enabled: widget.isAdded!
                                            ? widget.isAdded
                                            : isEdited,
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
                                              color: const Color(0xFFB7B7B7)),
                                          filled: true,
                                          fillColor: const Color(0xFFF6F6F6),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: _isSubmitted
                                                ? _validateTextField(
                                                            _rtController
                                                                .text) !=
                                                        ""
                                                    ? BorderSide.none
                                                    : BorderSide(
                                                        color: Colors.red)
                                                : BorderSide.none,
                                          ),
                                          suffixIcon: _isSubmitted
                                              ? _validateDropdown(
                                                          _rtController.text) !=
                                                      ""
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
                                          contentPadding:
                                              const EdgeInsets.all(12.0),
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
                                      width: 100,
                                      child: TextFormField(
                                        controller: _rwController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 3,
                                        enabled: widget.isAdded!
                                            ? widget.isAdded
                                            : isEdited,
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
                                              color: const Color(0xFFB7B7B7)),
                                          filled: true,
                                          fillColor: const Color(0xFFF6F6F6),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: _isSubmitted
                                                ? _validateTextField(
                                                            _rtController
                                                                .text) !=
                                                        ""
                                                    ? BorderSide.none
                                                    : BorderSide(
                                                        color: Colors.red)
                                                : BorderSide.none,
                                          ),
                                          suffixIcon: _isSubmitted
                                              ? _validateDropdown(
                                                          _rtController.text) !=
                                                      ""
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
                                          contentPadding:
                                              const EdgeInsets.all(12.0),
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
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
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
                                        // color: const Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Radius
                                      ),
                                      child: IgnorePointer(
                                        ignoring: widget.isAdded!
                                            ? isEdited
                                            : !isEdited,
                                        child: DropdownButtonFormField<String>(
                                          value: selectedProvince,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "",
                                              child: Text("Pilih Provinsi"),
                                            ),
                                            ...state.provinsiList['data']
                                                    ['Wilayah']
                                                .map<DropdownMenuItem<String>>(
                                                    (option) {
                                              return DropdownMenuItem<String>(
                                                value: option['KodeProvinsi']
                                                    .toString(),
                                                child: Text(
                                                  option['Provinsi'].toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                          onChanged: (String? newValue) {
                                            // Ini harus dynamic
                                            setState(() async {
                                              final user =
                                                  await SharedPreferencesUtil
                                                      .getData();
                                              selectedProvince = newValue ?? '';
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
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            border: InputBorder.none,
                                          ),
                                          hint: Text(
                                            'Pilih Provinsi',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFB7B7B7)),
                                          ),
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
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Kabupaten/Kota',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          BlocBuilder<KabupatenCubit, KabupatenState>(
                            builder: (context, state) {
                              if (state is KabupatenLoaded) {
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
                                        child: DropdownButtonFormField<String>(
                                          value: selectedKota,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "",
                                              child:
                                                  Text("Pilih Kabupaten/Kota"),
                                            ),
                                            ...state.kabupatenList['data']
                                                    ['Wilayah']
                                                .map<DropdownMenuItem<String>>(
                                                    (option) {
                                              return DropdownMenuItem<String>(
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
                                          validator: (value) {
                                            if (_isSubmitted) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Harus diisi';
                                              }
                                            }
                                            return null;
                                          },
                                          onChanged: (String? newValue) async {
                                            final user =
                                                await SharedPreferencesUtil
                                                    .getData();
                                            setState(() {
                                              selectedKota = newValue ?? '';
                                              context
                                                  .read<KecamatanCubit>()
                                                  .fetchKecamatanByKabupatenId(
                                                      selectedKota!,
                                                      user['data']['token']);
                                              selectedKecamatan = "";
                                              selectedKelurahan = "";
                                            });
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
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            border: InputBorder.none,
                                          ),
                                          hint: Text(
                                            'Pilih Kabupaten/Kota',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFB7B7B7)),
                                          ),
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
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
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
                                        child: DropdownButtonFormField<String>(
                                          value: selectedKecamatan,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "",
                                              child: Text("Pilih Kecamatan"),
                                            ),
                                            ...state.kecamatanList['data']
                                                    ['Wilayah']
                                                .map<DropdownMenuItem<String>>(
                                                    (option) {
                                              return DropdownMenuItem<String>(
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
                                          validator: (value) {
                                            if (_isSubmitted) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Harus diisi';
                                              }
                                            }
                                            return null;
                                          },
                                          onChanged: (String? newValue) async {
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
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFF6F6F6),
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
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            border: InputBorder.none,
                                          ),
                                          hint: Text(
                                            'Pilih Kecamatan',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFB7B7B7)),
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
                                  validator: (value) {
                                    if (_isSubmitted) {
                                      if (value == null || value.isEmpty) {
                                        return 'Harus diisi';
                                      }
                                    }
                                    return null;
                                  },
                                  onChanged: (String? newValue) {
                                    kecamatanDefault = newValue!;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFF6F6F6),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: _isSubmitted
                                          ? _validateDropdown(
                                                      kecamatanDefault!) ==
                                                  "Pilih Kecamatan"
                                              ? BorderSide.none
                                              : BorderSide(color: Colors.red)
                                          : BorderSide.none,
                                    ),
                                    suffixIcon: _isSubmitted
                                        ? _validateDropdown(
                                                    kecamatanDefault!) ==
                                                "Pilih Kecamatan"
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
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
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
                                        color: const Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Radius
                                      ),
                                      child: IgnorePointer(
                                        ignoring: widget.isAdded!
                                            ? isEdited
                                            : !isEdited,
                                        child: DropdownButtonFormField<String>(
                                          value: selectedKelurahan,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "",
                                              child: Text("Pilih Kelurahan"),
                                            ),
                                            ...state.kelurahanList['data']
                                                    ['Wilayah']
                                                .map<DropdownMenuItem<String>>(
                                                    (option) {
                                              return DropdownMenuItem<String>(
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
                                          decoration: const InputDecoration(
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
                                                color: const Color(0xFFB7B7B7)),
                                          ),
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
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Latitude & Longitude',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (widget.isAdded!) {
                                    getPickLocation();
                                  } else if (isEdited) {
                                    getPickLocation();
                                  }
                                },
                                child: Container(
                                  width: screenWidth * 0.75,
                                  child: TextField(
                                    controller: _latController,
                                    enabled: false,
                                    style: TextStyle(fontSize: 14.0),
                                    decoration: InputDecoration(
                                      hintText: "Pilih Lokasi",
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFB7B7B7)),
                                      filled: true,
                                      fillColor: const Color(0xFFF6F6F6),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.all(12.0),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (widget.isAdded!) {
                                    getPickLocation();
                                  } else if (isEdited) {
                                    getPickLocation();
                                  }
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const PickMapsPage()),
                                  // );
                                },
                                child: Container(
                                  width: screenWidth * 0.1,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Icon(Icons.location_on_outlined),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 70,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.all(10.0),
                          //   child: Text(
                          //     'Longitude',
                          //     style: GoogleFonts.poppins(
                          //         color: Color(0xFF2E2E2E),
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          // TextField(
                          //   controller: _lngController,
                          //   enabled: false,
                          //   decoration: InputDecoration(
                          //     hintText: "Input Longitude",
                          //     hintStyle: GoogleFonts.poppins(
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w500,
                          //         color: const Color(0xFFB7B7B7)),
                          //     filled: true,
                          //     fillColor: const Color(0xFFF6F6F6),
                          //     border: const OutlineInputBorder(
                          //         borderSide: BorderSide.none,
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(10))),
                          //     isDense: true,
                          //     contentPadding: const EdgeInsets.all(12.0),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.all(10.0),
                          //   child: Text(
                          //     'Nomor Kartu Keluarga',
                          //     style: GoogleFonts.poppins(
                          //         color: Color(0xFF2E2E2E),
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          // TextField(
                          //   controller: _kkController,
                          //   decoration: InputDecoration(
                          //     hintText: "Input Nomor KK",
                          //     hintStyle: GoogleFonts.poppins(
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w500,
                          //         color: const Color(0xFFB7B7B7)),
                          //     filled: true,
                          //     fillColor: const Color(0xFFF6F6F6),
                          //     border: const OutlineInputBorder(
                          //         borderSide: BorderSide.none,
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(10))),
                          //     isDense: true,
                          //     contentPadding: const EdgeInsets.all(12.0),
                          //   ),
                          // ),
                          // SizedBox(height: 10),
                          // widget.isAdded!
                          //     ? InkWell(
                          //         onTap: () async {
                          //           setState(() {
                          //             _isSubmitted = true;
                          //           });
                          //           final data =
                          //               await SharedPreferencesUtil.getData();
                          //           if (_formKey.currentState!.validate()) {
                          //             print(
                          //                 'ada ${_formKey.currentState?.validate()}');
                          //             lokasiCubit.postLokasiObject(
                          //                 data['data']['token'],
                          //                 '1',
                          //                 selectedIdentitasObjek,
                          //                 _alamatController.text,
                          //                 _rtController.text,
                          //                 _rwController.text,
                          //                 selectedKelurahan.toString(),
                          //                 selectedKecamatan.toString(),
                          //                 selectedKota.toString(),
                          //                 selectedProvince.toString(),
                          //                 _lat.toString(),
                          //                 _lng.toString());
                          //           } else {
                          //             print(
                          //                 'kosong ${_formKey.currentState?.validate()}');
                          //           }

                          //           // Navigator.push(
                          //           //   context,
                          //           //   MaterialPageRoute(
                          //           //       builder: (context) =>
                          //           //           const InputKependudukanPage()),
                          //           // );
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
                          //               ], // Ubah warna sesuai keinginan
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
                          //               lokasiCubit.editLokasiObject(
                          //                   data['data']['token'],
                          //                   widget.idLokasi.toString(),
                          //                   '1',
                          //                   selectedIdentitasObjek,
                          //                   _alamatController.text,
                          //                   _rtController.text,
                          //                   _rwController.text,
                          //                   selectedKelurahan.toString(),
                          //                   selectedKecamatan.toString(),
                          //                   selectedKota.toString(),
                          //                   selectedProvince.toString(),
                          //                   _lat.toString(),
                          //                   _lng.toString());
                          //               // Navigator.push(
                          //               //   context,
                          //               //   MaterialPageRoute(
                          //               //       builder: (context) =>
                          //               //           const InputKependudukanPage()),
                          //               // );
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
                final data = await SharedPreferencesUtil.getData();
                if (_formKey.currentState!.validate()) {
                  if (widget.isAdded!) {
                    final data = await SharedPreferencesUtil.getData();
                    // if (_formKey.currentState!.validate()) {
                    print('ada ${_formKey.currentState?.validate()}');
                    lokasiCubit.postLokasiObject(
                        data['data']['token'],
                        '1',
                        selectedIdentitasObjek,
                        _alamatController.text,
                        _rtController.text,
                        _rwController.text,
                        selectedKelurahan.toString(),
                        selectedKecamatan.toString(),
                        selectedKota.toString(),
                        selectedProvince.toString(),
                        _lat.toString(),
                        _lng.toString());
                    // }
                  } else if (isEdited) {
                    lokasiCubit.editLokasiObject(
                        data['data']['token'],
                        widget.idLokasi.toString(),
                        '1',
                        selectedIdentitasObjek,
                        _alamatController.text,
                        _rtController.text,
                        _rwController.text,
                        selectedKelurahan.toString(),
                        selectedKecamatan.toString(),
                        selectedKota.toString(),
                        selectedProvince.toString(),
                        _lat.toString(),
                        _lng.toString());
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
                      // color: Colors.amber,
                      // offset: Offset(-60, 0),
                      // onSelected: (value) {
                      //   // Handle menu item selection
                      //   print('Selected: $value');
                      // },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                                screenWidth * 0.95, screenHeight * 0.89, 0, 0),
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
                              // PopupMenuItem<String>(
                              //   value: 'option2',
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Container(
                              //         width: 40,
                              //         height: 40,
                              //         margin:
                              //             EdgeInsets.only(bottom: 0, right: 4),
                              //         decoration: BoxDecoration(
                              //           color: AppColors.dangerColor,
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: Color(0xFFe5e5e5),
                              //               blurRadius: 10,
                              //               offset: Offset(0, 0),
                              //               spreadRadius: 0.5,
                              //             ),
                              //           ],
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(10)),
                              //         ),
                              //         child: Material(
                              //           color: Colors.transparent,
                              //           child: Icon(
                              //             Icons.delete,
                              //             color: Colors.white,
                              //             size: 20,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //   onTap: () async {
                              //     final user =
                              //         await SharedPreferencesUtil.getData();
                              //     setState(() {
                              //       // kependudukanCubit.deleteKepalaKeluarga(
                              //       //     user['data']['token'],
                              //       //     widget.idKepalaKeluarga.toString());
                              //     });
                              //     // _dialogDelete(context, kependudukanCubit);
                              //     // Navigator.pop(context, true);
                              //   },
                              // ),
                            ]);
                      },

                      // },
                      child: Icon(Icons.menu, color: AppColors.primaryColor),
                    ),
                  ),
          ],
        ),
      ),
      // floatingActionButton: widget.isAdded!
      //     ? Container()
      //     : isEdited
      //         ? Container()
      //         : Container(
      //             width: 50,
      //             height: 50,
      //             decoration: const BoxDecoration(
      //               color: AppColors.primaryColor,
      //               shape: BoxShape.circle,
      //             ),
      //             child: PopupMenuButton<String>(
      //               offset: Offset(-60, 0),
      //               onSelected: (value) {
      //                 // Handle menu item selection
      //                 print('Selected: $value');
      //               },
      //               itemBuilder: (BuildContext context) {
      //                 return <PopupMenuEntry<String>>[
      //                   PopupMenuItem<String>(
      //                     value: 'option1',
      //                     child: Text('Edit Data'),
      //                     onTap: () {
      //                       setState(() {
      //                         isEdited = !isEdited;
      //                       });
      //                     },
      //                   ),
      //                   PopupMenuItem<String>(
      //                     value: 'option2',
      //                     child: Text('Hapus Data'),
      //                     onTap: () async {
      //                       final user = await SharedPreferencesUtil.getData();
      //                       setState(() {});
      //                       Navigator.pop(context, true);
      //                     },
      //                   ),
      //                 ];
      //               },
      //               child: Icon(Icons.more_vert, color: AppColors.white),
      //             ),
      //           ),
    );
  }

  void _dialogLokasiObjek(BuildContext context, dynamic data) {
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
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 80,
                ),
                Text(
                  'Pemberitahuan',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  data['message'],
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
                // Navigator.of(context).pop();
                dynamic dataLokasi = data['data'];
                print('suces $dataLokasi');
                // Navigator.of(context, rootNavigator: true).pop();
                // Navigator.of(context, rootNavigator: true).pop(dataLokasi);
                Navigator.of(context).pop();
                Navigator.of(context).pop(dataLokasi);

                // Melakukan pushReplacement
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           const LoginPage()), // Gantilah dengan halaman yang sesuai
                //   (route) =>
                //       false, // Callback untuk menutup semua halaman saat ini
                // );
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
