// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/master/agama/agama_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/master/goldar/golongan_darah_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/master/pendidikan/pendidikan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/models/kependudukan.dart';
import 'package:sistem_pendataan_kewilayahan/utils/app_colors.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/bansos/bansos_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/login/login_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/ppks/ppks_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/psks/psks_page.dart';

class InputAnggotaPage extends StatefulWidget {
  bool? isAdded;
  final String? idPic;
  final int? idAnggota;
  final String? noKk;
  final String? noNik;
  final String? namaLengkap;
  final String? jk;
  final String? tempat;
  final String? tglLahir;
  final String? goldar;
  final String? agama;
  final String? pendidikan;
  final String? pekerjaan;
  final String? pernikahan;
  final String? hubungan;
  final String? warga;
  final String? ayah;
  final String? ibu;
  final String? yatimpiatu;

  InputAnggotaPage({
    this.idPic,
    this.isAdded,
    this.idAnggota,
    this.noKk,
    this.noNik,
    this.namaLengkap,
    this.jk,
    this.tempat,
    this.tglLahir,
    this.goldar,
    this.agama,
    this.pendidikan,
    this.pekerjaan,
    this.pernikahan,
    this.hubungan,
    this.warga,
    this.ayah,
    this.ibu,
    this.yatimpiatu,
    super.key,
  });

  @override
  State<InputAnggotaPage> createState() => _InputAnggotaPageState();
}

class _InputAnggotaPageState extends State<InputAnggotaPage> {
  DateTime selectedDate = DateTime.now();
  bool isAlertDialogShown = false;
  bool isEdited = false;
  String selectedOption = '1';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;

  List<Map<String, dynamic>> receivedData = [];
  List<dynamic> psksData = [];
  List<Map<String, dynamic>> receivedDataPPKS = [];
  List<dynamic> ppksData = [];
  List<Map<String, dynamic>> receivedDataBansos = [];
  List<dynamic> bansosData = [];
  String selectedValue = "";
  List<Map<String, dynamic>> options = [
    {'value': '1', 'nama': 'Laki-laki'},
    {'value': '2', 'nama': 'Perempuan'}
  ];
  String selectedPernikahan = "";
  List<Map<String, dynamic>> statusPernikahan = [
    {"id": "1", "nmStatus": "belum kawin"},
    {"id": "2", "nmStatus": "kawin"},
    {"id": "3", "nmStatus": "cerai hidup"},
    {"id": "4", "nmStatus": "cerai mati"},
    {"id": "5", "nmStatus": "cerai tidak jadi"},
  ];

  String selectedHubungan = "";
  List<Map<String, dynamic>> statusHubungan = [
    {"id": "1", "nmHubungan": "Kepala Keluarga"},
    {"id": "2", "nmHubungan": "Suami"},
    {"id": "3", "nmHubungan": "Istri"},
    {"id": "4", "nmHubungan": "Anak"},
    {"id": "5", "nmHubungan": "Menantu"},
    {"id": "6", "nmHubungan": "Cucu"},
    {"id": "7", "nmHubungan": "Orangtua"},
    {"id": "8", "nmHubungan": "Mertua"},
    {"id": "9", "nmHubungan": "Famili Lain"},
    {"id": "10", "nmHubungan": "Pembantu"},
    {"id": "11", "nmHubungan": "Lainnya"},
  ];

  String selectedKewarganegaraan = "";
  List<Map<String, dynamic>> statusKewarganegaraan = [
    {"id": "1", "nmKewarganegaraan": "WNI"},
    {"id": "2", "nmKewarganegaraan": "WNA"},
  ];

  String selectedPendidikan = "";
  List<Map<String, dynamic>> statusPendidikan = [
    {"id": "1", "pendidikan": "Tidak / Belum Sekolah"},
    {"id": "2", "pendidikan": "Belum Tamat SD/Sederajat"},
    {"id": "3", "pendidikan": "Tamat SD / Sederajat"},
    {"id": "4", "pendidikan": "SLTP / Sederaiat"},
    {"id": "5", "pendidikan": "SLTA / Sederajat"},
    {"id": "6", "pendidikan": "Diploma I / II"},
    {"id": "7", "pendidikan": "Akademi / Diploma III / Sariana Muda"},
    {"id": "8", "pendidikan": "Diploma IV / Strata I"},
    {"id": "9", "pendidikan": "Strata II"},
    {"id": "10", "pendidikan": "Strata III"},
  ];
  String selectedGoldar = "";
  // String selectedGoldar = "Pilih Golongan Darah";
  List<String> GoldarData = ["Pilih Golongan Darah"];
  List<Map<String, dynamic>> statusGoldar = [
    {"id": "1", "goldar": "A"},
    {"id": "2", "goldar": "B"},
    {"id": "3", "goldar": "AB"},
    {"id": "4", "goldar": "O"},
    {"id": "5", "goldar": "A+"},
    {"id": "6", "goldar": "B+"},
  ];
  String selectedAgama = "";
  List<Map<String, dynamic>> statusAgama = [
    // {"id": "", "agama": "Pilih Agama"},
    {"id": "1", "agama": "Islam"},
    {"id": "2", "agama": "Kristen"},
    {"id": "3", "agama": "Katholik"},
    {"id": "4", "agama": "Hindu"},
    {"id": "5", "agama": "Budha"},
  ];

  String selectedPekerjaan = "";
  List<Map<String, dynamic>> statusPekerjaan = [
    {"id": "1", "pekerjaan": "Belum/ Tidak Bekerja"},
    {"id": "2", "pekerjaan": "Mengurus Rumah Tangga"},
    {"id": "3", "pekerjaan": "Pelajar/ Mahasiswa"},
    {"id": "4", "pekerjaan": "Pensiunan"},
    {"id": "5", "pekerjaan": "Pewagai Negeri Sipil"},
    {"id": "6", "pekerjaan": "Tentara Nasional Indonesia"},
    {"id": "7", "pekerjaan": "Kepolisisan RI"},
    {"id": "8", "pekerjaan": "Perdagangan"},
    {"id": "9", "pekerjaan": "Petani/ Pekebun"},
    {"id": "10", "pekerjaan": "Peternak"},
    {"id": "11", "pekerjaan": "Nelayan/ Perikanan"},
    {"id": "12", "pekerjaan": "Industri"},
    {"id": "13", "pekerjaan": "Konstruksi"},
    {"id": "14", "pekerjaan": "Transportasi"},
    {"id": "15", "pekerjaan": "Karyawan Swasta"},
    {"id": "16", "pekerjaan": "Karyawan BUMN"},
    {"id": "17", "pekerjaan": "Karyawan BUMD"},
    {"id": "18", "pekerjaan": "Karyawan Honorer"},
    {"id": "19", "pekerjaan": "Buruh Harian Lepas"},
    {"id": "20", "pekerjaan": "Buruh Tani/ Perkebunan"},
    {"id": "21", "pekerjaan": "Buruh Nelayan/ Perikanan"},
    {"id": "22", "pekerjaan": "Buruh Peternakan"},
    {"id": "23", "pekerjaan": "Pembantu Rumah Tangga"},
    {"id": "24", "pekerjaan": "Tukang Cukur"},
    {"id": "25", "pekerjaan": "Tukang Listrik"},
    {"id": "26", "pekerjaan": "Tukang Batu"},
    {"id": "27", "pekerjaan": "Tukang Kayu"},
    {"id": "28", "pekerjaan": "Tukang Sol Sepatu"},
    {"id": "29", "pekerjaan": "Tukang Las/ Pandai Besi"},
    {"id": "30", "pekerjaan": "Tukang Jahit"},
    {"id": "31", "pekerjaan": "Tukang Gigi"},
    {"id": "32", "pekerjaan": "Penata Rias"},
    {"id": "33", "pekerjaan": "Penata Busana"},
    {"id": "34", "pekerjaan": "Penata Rambut"},
    {"id": "35", "pekerjaan": "Mekanik"},
    {"id": "36", "pekerjaan": "Seniman"},
    {"id": "37", "pekerjaan": "Tabib"},
    {"id": "38", "pekerjaan": "Paraji"},
    {"id": "39", "pekerjaan": "Perancang Busana"},
    {"id": "40", "pekerjaan": "Penterjemah"},
    {"id": "41", "pekerjaan": "Imam Masjid"},
    {"id": "42", "pekerjaan": "Pendeta"},
    {"id": "43", "pekerjaan": "Pastor"},
    {"id": "44", "pekerjaan": "Wartawan"},
    {"id": "45", "pekerjaan": "Ustadz/ Mubaligh"},
    {"id": "46", "pekerjaan": "Juru Masak"},
    {"id": "47", "pekerjaan": "Promotor Acara"},
    {"id": "48", "pekerjaan": "Anggota DPR-RI"},
    {"id": "49", "pekerjaan": "Anggota DPD"},
    {"id": "50", "pekerjaan": "Anggota BPK"},
    {"id": "51", "pekerjaan": "Presiden"},
    {"id": "52", "pekerjaan": "Wakil Presiden"},
    {"id": "53", "pekerjaan": "Anggota Mahkamah Konstitusi"},
    {"id": "54", "pekerjaan": "Anggota Kabinet/ Kementerian"},
    {"id": "55", "pekerjaan": "Duta Besar"},
    {"id": "56", "pekerjaan": "Gubernur"},
    {"id": "57", "pekerjaan": "Wakil Gubernur"},
    {"id": "58", "pekerjaan": "Bupati"},
    {"id": "59", "pekerjaan": "Wakil Bupati"},
    {"id": "60", "pekerjaan": "Walikota"},
    {"id": "61", "pekerjaan": "Wakil Walikota"},
    {"id": "62", "pekerjaan": "Anggota DPRD Provinsi"},
    {"id": "63", "pekerjaan": "Anggota DPRD Kabupaten/ Kota"},
    {"id": "64", "pekerjaan": "Dosen"},
    {"id": "65", "pekerjaan": "Guru"},
    {"id": "66", "pekerjaan": "Pilot"},
    {"id": "67", "pekerjaan": "Pengacara"},
    {"id": "68", "pekerjaan": "Notaris"},
    {"id": "69", "pekerjaan": "Arsitek"},
    {"id": "70", "pekerjaan": "Akuntan"},
    {"id": "71", "pekerjaan": "Konsultan"},
    {"id": "72", "pekerjaan": "Dokter"},
    {"id": "73", "pekerjaan": "Bidan"},
    {"id": "74", "pekerjaan": "Perawat"},
    {"id": "75", "pekerjaan": "Apoteker"},
    {"id": "76", "pekerjaan": "Psikiater/ Psikolog"},
    {"id": "77", "pekerjaan": "Penyiar Televisi"},
    {"id": "78", "pekerjaan": "Penyiar Radio"},
    {"id": "79", "pekerjaan": "Pelaut"},
    {"id": "80", "pekerjaan": "Peneliti"},
    {"id": "81", "pekerjaan": "Sopir"},
    {"id": "82", "pekerjaan": "Pialang"},
    {"id": "83", "pekerjaan": "Paranormal"},
    {"id": "84", "pekerjaan": "Pedagang"},
    {"id": "85", "pekerjaan": "Perangkat Desa"},
    {"id": "86", "pekerjaan": "Kepala Desa"},
    {"id": "87", "pekerjaan": "Biarawati"},
    {"id": "88", "pekerjaan": "Wiraswasta"},
  ];

  List<Kependudukan> _items = [];
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _kkController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _jkController = TextEditingController();
  TextEditingController _tempatController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _goldarController = TextEditingController();
  TextEditingController _agamaController = TextEditingController();
  TextEditingController _pendidikanController = TextEditingController();
  TextEditingController _pekerjaanController = TextEditingController();
  TextEditingController _pernikahanController = TextEditingController();
  TextEditingController _hubunganController = TextEditingController();
  TextEditingController _kwnController = TextEditingController();
  TextEditingController _ayahController = TextEditingController();
  TextEditingController _ibuController = TextEditingController();
  TextEditingController _yatimpiatuController = TextEditingController();
  TextEditingController _usahaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _loadItems();
    if (widget.tglLahir != null) {
      DateTime originalDate = DateTime.parse(widget.tglLahir ?? "");

      String formattedDate =
          "${originalDate.year}-${_twoDigits(originalDate.month)}-${_twoDigits(originalDate.day)}";
      _tanggalController.text = formattedDate;
    }

    // isEdited = widget.isAdded!;
    _kkController.text = widget.noKk ?? '';
    _nikController.text = widget.noNik ?? '';
    _namaController.text = widget.namaLengkap ?? '';
    selectedValue = widget.jk ?? '';
    _tempatController.text = widget.tempat ?? '';
    // _goldarController.text = widget.goldar ?? '';
    selectedGoldar = widget.goldar ?? '';
    // _agamaController.text = widget.agama ?? '';
    selectedAgama = widget.agama ?? '';
    // _pendidikanController.text = widget.pendidikan ?? '';
    selectedPendidikan = widget.pendidikan ?? '';
    // _pekerjaanController.text = widget.pekerjaan ?? '';
    selectedPekerjaan = widget.pekerjaan ?? '';
    selectedHubungan = widget.hubungan ?? '';
    selectedKewarganegaraan = widget.warga ?? '';
    // print('warga negara ${widget.warga}');

    // Map<String, dynamic>? foundPernikahan = statusPernikahan.firstWhere(
    //     (element) => element["nmStatus"] == widget.pernikahan,
    //     orElse: () => {});

    // Map<String, dynamic>? foundHubungaan = statusHubungan.firstWhere(
    //     (element) => element["nmHubungan"] == widget.hubungan,
    //     orElse: () => {});
    selectedPernikahan = widget.pernikahan ?? "";
    selectedHubungan = widget.hubungan ?? "";
    _kwnController.text = widget.warga ?? '';
    _ayahController.text = widget.ayah ?? '';
    _ibuController.text = widget.ibu ?? '';
    selectedOption = widget.yatimpiatu ?? '1';

    getPSKS(widget.noNik ?? '');
    getMaster();
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    }
    return "0$n";
  }

  Future<void> getMaster() async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      context
          .read<GolonganDarahCubit>()
          .getGolonganDarah(data['data']['token']);
      context.read<AgamaCubit>().getAgama(data['data']['token']);
      context.read<PendidikanCubit>().getPendidikan(data['data']['token']);
    }
  }

  Future<void> getPSKS(String nik) async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      context.read<PsksCubit>().getPSKS(data['data']['token'], nik);
      context.read<PpksCubit>().getPPKS(data['data']['token'], nik);
      context.read<BansosCubit>().getBansos(data['data']['token'], nik);
      // context.read<BansosCubit>().getBansos(data['data']['token'], nik);
    }
  }

  Future<void> postAnggotaKeluarga(
    String nomorKK,
    String nik,
    String nama,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String agama,
    String pendidikan,
    String jenisPekerjaan,
    String statusPernikahan,
    String statusHubunganKeluarga,
    String kewarganegaraan,
    String namaAyah,
    String namaIbu,
    String goldar,
    String yatimPiatu,
    String usaha,
  ) async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<KependudukanCubit>().postAnggotaKeluarga(
              data['data']['token'],
              nomorKK,
              nik,
              nama,
              jenisKelamin,
              tempatLahir,
              tanggalLahir,
              agama,
              pendidikan,
              jenisPekerjaan,
              statusPernikahan,
              statusHubunganKeluarga,
              kewarganegaraan,
              namaAyah,
              namaIbu,
              goldar,
              yatimPiatu,
              usaha,
            );
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _tanggalController.text =
            DateFormat("yyyy-MM-dd").format(DateTime.parse("$picked"));
      });
    }
  }

  void handleRadioValueChanged(String? value) {
    setState(() {
      selectedOption = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final kependudukanCubit = context.read<KependudukanCubit>();
    final psksCubit = context.read<PsksCubit>();
    final ppksCubit = context.read<PpksCubit>();
    final bansosCubit = context.read<BansosCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4FC4CF),
                      Color(0xFFa3e0e5)
                    ], // Ubah warna sesuai keinginan
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
                    'DATA ANGGOTA KELUARGA',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
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
                  }
                  if (state is ResponseDeleteData) {
                    // await SharedPreferencesUtil.removeUser();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _dialogInputResponse(context, state.isResponse);
                    });
                  }
                  if (state is DataAnggotaFailure) {
                    isAlertDialogShown = true;
                    // });
                    // if (FocusScope.of(context).hasFocus) {
                    // Periksa apakah keyboard tidak aktif

                    // if (isAlertDialogShown) {
                    // if (state.isResponse) {
                    // if (isAlertDialogShown) {

                    print('status ${state.isResponse}');
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _dialogResponse(context, state.isResponse);
                    });
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Teks di tengah
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               const InputLokasiPage()),
                          //     );
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //         top: 10.0, left: 10.0, right: 10.0),
                          //     child: Text(
                          //       'Lokasi Objek',
                          //       style: GoogleFonts.poppins(
                          //           color: Color(0xFF2E2E2E),
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w600),
                          //     ),
                          //   ),
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               const InputLokasiPage()),
                          //     );
                          //   },
                          //   child: Container(
                          //     margin: const EdgeInsets.only(
                          //         top: 10.0, bottom: 10.0),
                          //     child: TextField(
                          // enabled: widget.isAdded!
                          // ? widget.isAdded
                          // : isEdited,
                          //       controller: _lokasiController,
                          //       decoration: InputDecoration(
                          //         hintText: "Input Lokasi Objek",
                          //         hintStyle: GoogleFonts.poppins(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w500,
                          //             color: const Color(0xFFB7B7B7)),
                          //         filled: true,
                          //         fillColor: const Color(0xFFF6F6F6),
                          //         border: const OutlineInputBorder(
                          //             borderSide: BorderSide.none,
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(10))),
                          //         isDense: true,
                          //         contentPadding: EdgeInsets.all(12.0),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
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
                            enabled: widget.noKk == null || widget.noKk == ''
                                ? widget.isAdded!
                                    ? widget.isAdded
                                    : isEdited
                                : false,
                            controller: _kkController,
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
                              hintText: "Input Nomor KK",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB7B7B7)),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              errorBorder: OutlineInputBorder(
                                borderSide: _isSubmitted
                                    ? _validateTextField(_kkController.text) !=
                                                '' ||
                                            _kkController.text.length == 16
                                        ? BorderSide.none
                                        : BorderSide(color: Colors.red)
                                    : BorderSide.none,
                              ),
                              suffixIcon: _isSubmitted
                                  ? _validateTextField(_kkController.text) !=
                                              '' ||
                                          _kkController.text.length == 16
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
                              contentPadding: const EdgeInsets.all(12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Nomor Induk Kependudukan',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _nikController,
                            maxLength: 16,
                            enabled:
                                widget.isAdded! ? widget.isAdded : isEdited,
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
                              hintText: "Input NIK",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB7B7B7)),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              errorBorder: OutlineInputBorder(
                                borderSide: _isSubmitted
                                    ? _validateTextField(_nikController.text) !=
                                            ''
                                        ? BorderSide.none
                                        : BorderSide(color: Colors.red)
                                    : BorderSide.none,
                              ),
                              suffixIcon: _isSubmitted
                                  ? _validateTextField(_nikController.text) !=
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
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Nama Lengkap',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            controller: _namaController,
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
                              hintText: "Input Nama Lengkap",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB7B7B7)),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              errorBorder: OutlineInputBorder(
                                borderSide: _isSubmitted
                                    ? _validateTextField(_nikController.text) !=
                                            ''
                                        ? BorderSide.none
                                        : BorderSide(color: Colors.red)
                                    : BorderSide.none,
                              ),
                              suffixIcon: _isSubmitted
                                  ? _validateTextField(_nikController.text) !=
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
                              contentPadding: const EdgeInsets.all(12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Jenis Kelamin',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10.0), // Radius
                            ),
                            child: IgnorePointer(
                              ignoring: widget.isAdded! ? isEdited : !isEdited,
                              child: DropdownButtonFormField<String>(
                                // DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedValue,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text(
                                      "Pilih Jenis Kelamin",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ...options.map((Map<String, dynamic> option) {
                                    return DropdownMenuItem<String>(
                                      // value: option,
                                      value: option['value'].toString(),
                                      child: Text(
                                        option['nama'].toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (String? newValue) {
                                  // onChanged: (Map<String, dynamic>? newValue) {
                                  setState(() {
                                    selectedValue =
                                        newValue ?? ''; // Default jika null
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
                                  isDense: true,
                                  filled: true,
                                  fillColor: const Color(0xFFF6F6F6),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: _isSubmitted
                                        ? _validateDropdown(selectedValue) != ""
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  suffixIcon: _isSubmitted
                                      ? _validateDropdown(selectedValue) != ""
                                          ? null
                                          : Icon(
                                              Icons.error,
                                              color: AppColors.dangerColor,
                                            )
                                      : null,
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Tempat Lahir',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            controller: _tempatController,
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
                              hintText: "Input Tempat Lahir",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB7B7B7)),
                              filled: true,
                              fillColor: Color(0xFFF6F6F6),
                              errorBorder: OutlineInputBorder(
                                borderSide: _isSubmitted
                                    ? _validateTextField(
                                                _tempatController.text) !=
                                            ""
                                        ? BorderSide.none
                                        : BorderSide(color: Colors.red)
                                    : BorderSide.none,
                              ),
                              suffixIcon: _isSubmitted
                                  ? _validateTextField(
                                              _tempatController.text) !=
                                          ""
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
                              contentPadding: const EdgeInsets.all(12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Tanggal Lahir',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (!isEdited) {
                                _selectDate(context);
                              }
                            },
                            child: TextFormField(
                              controller: _tanggalController,
                              enabled: false,
                              // enabled: widget.isAdded! ? widget.isAdded : isEdited,
                              validator: (value) {
                                if (_isSubmitted) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus diisi';
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Input Tanggal Lahir",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFB7B7B7)),
                                filled: true,
                                fillColor: const Color(0xFFF6F6F6),
                                errorBorder: OutlineInputBorder(
                                  borderSide: _isSubmitted
                                      ? _validateTextField(
                                                  _tanggalController.text) !=
                                              ""
                                          ? BorderSide.none
                                          : BorderSide(color: Colors.red)
                                      : BorderSide.none,
                                ),
                                suffixIcon: _isSubmitted
                                    ? _validateTextField(
                                                _tanggalController.text) !=
                                            ""
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
                                contentPadding: const EdgeInsets.all(12.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Golongan Darah',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          /** Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: IgnorePointer(
                              ignoring: widget.isAdded! ? isEdited : !isEdited,
                              child: DropdownButtonFormField<String>(
                                // DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedGoldar,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text(
                                      "Pilih Golongan Darah",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ...statusGoldar
                                      .map<DropdownMenuItem<String>>((option) {
                                    return DropdownMenuItem<String>(
                                      // value: option,
                                      value: option['id'].toString(),
                                      child: Text(
                                        option['goldar'].toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (String? newValue) {
                                  // onChanged: (Map<String, dynamic>? newValue) {
                                  setState(() {
                                    selectedGoldar =
                                        newValue ?? ''; // Default jika null
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
                                  isDense: true,
                                  filled: true,
                                  fillColor: const Color(0xFFF6F6F6),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: _isSubmitted
                                        ? _validateDropdown(selectedGoldar) !=
                                                ""
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  suffixIcon: _isSubmitted
                                      ? _validateDropdown(selectedGoldar) != ""
                                          ? null
                                          : Icon(
                                              Icons.error,
                                              color: AppColors.dangerColor,
                                            )
                                      : null,
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                ),
                                hint: Text(
                                  'Pilih Golongan Darah',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFB7B7B7)),
                                ),
                              ),
                            ),
                          ),**/
                          BlocBuilder<GolonganDarahCubit, GolonganDarahState>(
                            builder: (context, state) {
                              if (state is GolonganDarahLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is GolonganDarahError) {
                                return Center(
                                  child: Text(
                                    state.error,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              } else if (state is GolonganDarahSuccess) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: IgnorePointer(
                                    ignoring:
                                        widget.isAdded! ? isEdited : !isEdited,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedGoldar,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "",
                                          child: Text(
                                            "Pilih Golongan Darah",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        ...state.data['data']['master']
                                            .map<DropdownMenuItem<String>>(
                                                (option) {
                                          return DropdownMenuItem<String>(
                                            value: option['id'].toString(),
                                            child: Text(
                                              option['nama'].toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGoldar = newValue ?? '';
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
                                        isDense: true,
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: _isSubmitted
                                              ? _validateDropdown(
                                                          selectedGoldar) !=
                                                      ""
                                                  ? BorderSide.none
                                                  : BorderSide(
                                                      color: Colors.red)
                                              : BorderSide.none,
                                        ),
                                        suffixIcon: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedGoldar) !=
                                                    ""
                                                ? null
                                                : Icon(
                                                    Icons.error,
                                                    color:
                                                        AppColors.dangerColor,
                                                  )
                                            : null,
                                        contentPadding:
                                            const EdgeInsets.all(12.0),
                                        border: InputBorder.none,
                                      ),
                                      hint: Text(
                                        'Pilih Golongan Darah',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFB7B7B7),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Agama',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          BlocBuilder<AgamaCubit, AgamaState>(
                            builder: (context, state) {
                              if (state is AgamaLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is AgamaError) {
                                return Center(
                                  child: Text(
                                    state.error,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              } else if (state is AgamaSuccess) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: IgnorePointer(
                                    ignoring:
                                        widget.isAdded! ? isEdited : !isEdited,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedAgama,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "",
                                          child: Text(
                                            "Pilih Agama",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        ...state.data['data']['master']
                                            .map<DropdownMenuItem<String>>(
                                                (option) {
                                          return DropdownMenuItem<String>(
                                            value: option['id'].toString(),
                                            child: Text(
                                              option['nama'].toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedAgama = newValue ?? '';
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
                                        isDense: true,
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: _isSubmitted
                                              ? _validateDropdown(
                                                          selectedAgama) !=
                                                      ""
                                                  ? BorderSide.none
                                                  : BorderSide(
                                                      color: Colors.red)
                                              : BorderSide.none,
                                        ),
                                        suffixIcon: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedAgama) !=
                                                    ""
                                                ? null
                                                : Icon(
                                                    Icons.error,
                                                    color:
                                                        AppColors.dangerColor,
                                                  )
                                            : null,
                                        contentPadding:
                                            const EdgeInsets.all(12.0),
                                        border: InputBorder.none,
                                      ),
                                      hint: Text(
                                        'Pilih Agama',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFB7B7B7),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(10.0), // Radius
                                ),
                                child: IgnorePointer(
                                  ignoring:
                                      widget.isAdded! ? isEdited : !isEdited,
                                  child: DropdownButtonFormField<String>(
                                    // DropdownButtonFormField<Map<String, dynamic>>(
                                    value: selectedAgama,
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "",
                                        child: Text(
                                          "Pilih Agama",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      ...statusAgama
                                          .map((Map<String, dynamic> option) {
                                        return DropdownMenuItem<String>(
                                          // value: option,
                                          value: option['id'].toString(),
                                          child: Text(
                                            option['agama'].toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                    onChanged: (String? newValue) {
                                      // onChanged: (Map<String, dynamic>? newValue) {
                                      setState(() {
                                        selectedAgama =
                                            newValue ?? ''; // Default jika null
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
                                      isDense: true,
                                      filled: true,
                                      fillColor: const Color(0xFFF6F6F6),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedAgama) !=
                                                    ''
                                                ? BorderSide.none
                                                : BorderSide(color: Colors.red)
                                            : BorderSide.none,
                                      ),
                                      suffixIcon: _isSubmitted
                                          ? _validateDropdown(selectedAgama) !=
                                                  ''
                                              ? null
                                              : Icon(
                                                  Icons.error,
                                                  color: AppColors.dangerColor,
                                                )
                                          : null,
                                      contentPadding:
                                          const EdgeInsets.all(12.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Pendidikan',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          BlocBuilder<PendidikanCubit, PendidikanState>(
                            builder: (context, state) {
                              if (state is PendidikanLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is PendidikanError) {
                                return Center(
                                  child: Text(
                                    state.error,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              } else if (state is PendidikanSuccess) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: IgnorePointer(
                                    ignoring:
                                        widget.isAdded! ? isEdited : !isEdited,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedAgama,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "",
                                          child: Text(
                                            "Pilih Pendidikan",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        ...state.data['data']['master']
                                            .map<DropdownMenuItem<String>>(
                                                (option) {
                                          return DropdownMenuItem<String>(
                                            value: option['id'].toString(),
                                            child: Text(
                                              option['nama'].toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedPendidikan = newValue ?? '';
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
                                        isDense: true,
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F6),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: _isSubmitted
                                              ? _validateDropdown(
                                                          selectedPendidikan) !=
                                                      ""
                                                  ? BorderSide.none
                                                  : BorderSide(
                                                      color: Colors.red)
                                              : BorderSide.none,
                                        ),
                                        suffixIcon: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedPendidikan) !=
                                                    ""
                                                ? null
                                                : Icon(
                                                    Icons.error,
                                                    color:
                                                        AppColors.dangerColor,
                                                  )
                                            : null,
                                        contentPadding:
                                            const EdgeInsets.all(12.0),
                                        border: InputBorder.none,
                                      ),
                                      hint: Text(
                                        'Pilih Pendidikan',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFB7B7B7),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(10.0), // Radius
                                ),
                                child: IgnorePointer(
                                  ignoring:
                                      widget.isAdded! ? isEdited : !isEdited,
                                  child: DropdownButtonFormField<String>(
                                    // DropdownButtonFormField<Map<String, dynamic>>(
                                    value: selectedPendidikan,
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "",
                                        child: Text(
                                          "Pilih Pendidikan",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      ...statusPendidikan
                                          .map((Map<String, dynamic> option) {
                                        return DropdownMenuItem<String>(
                                          // value: option,
                                          value: option['id'].toString(),
                                          child: Text(
                                            option['pendidikan'].toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                    onChanged: (String? newValue) {
                                      // onChanged: (Map<String, dynamic>? newValue) {
                                      setState(() {
                                        selectedPendidikan =
                                            newValue ?? ''; // Default jika null
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
                                      isDense: true,
                                      filled: true,
                                      fillColor: const Color(0xFFF6F6F6),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: _isSubmitted
                                            ? _validateDropdown(
                                                        selectedPendidikan) !=
                                                    ''
                                                ? BorderSide.none
                                                : BorderSide(color: Colors.red)
                                            : BorderSide.none,
                                      ),
                                      suffixIcon: _isSubmitted
                                          ? _validateDropdown(
                                                      selectedPendidikan) !=
                                                  ''
                                              ? null
                                              : Icon(
                                                  Icons.error,
                                                  color: AppColors.dangerColor,
                                                )
                                          : null,
                                      contentPadding:
                                          const EdgeInsets.all(12.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.circular(10.0), // Radius
                          //   ),
                          //   child: DropdownButtonFormField<String>(
                          //     // DropdownButtonFormField<Map<String, dynamic>>(
                          //     value: selectedPendidikan,
                          //     items: [
                          //       DropdownMenuItem<String>(
                          //         value: "",
                          //         child: Text(
                          //           "Pilih Pendidikan",
                          //           style: GoogleFonts.poppins(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w500),
                          //         ),
                          //       ),
                          //       ...statusPendidikan
                          //           .map((Map<String, dynamic> option) {
                          //         return DropdownMenuItem<String>(
                          //           // value: option,
                          //           value: option['id'].toString(),
                          //           child: Text(
                          //             option['pendidikan'].toString(),
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 14,
                          //             ),
                          //           ),
                          //         );
                          //       }).toList(),
                          //     ],
                          //     onChanged: (String? newValue) {
                          //       // onChanged: (Map<String, dynamic>? newValue) {
                          //       setState(() {
                          //         selectedPendidikan =
                          //             newValue ?? ''; // Default jika null
                          //       });
                          //     },
                          //     validator: (value) {
                          //       if (_isSubmitted) {
                          //         if (value == null || value.isEmpty) {
                          //           return 'Harus diisi';
                          //         }
                          //       }
                          //       return null;
                          //     },
                          //     decoration: InputDecoration(
                          //       isDense: true,
                          //       filled: true,
                          //       fillColor: const Color(0xFFF6F6F6),
                          //       errorBorder: OutlineInputBorder(
                          //         borderSide: _isSubmitted
                          //             ? _validateDropdown(selectedAgama) != ''
                          //                 ? BorderSide.none
                          //                 : BorderSide(color: Colors.red)
                          //             : BorderSide.none,
                          //       ),
                          //       suffixIcon: _isSubmitted
                          //           ? _validateDropdown(selectedAgama) != ''
                          //               ? null
                          //               : Icon(
                          //                   Icons.error,
                          //                   color: AppColors.dangerColor,
                          //                 )
                          //           : null,
                          //       contentPadding: const EdgeInsets.all(12.0),
                          //       border: InputBorder.none,
                          //     ),
                          //   ),
                          // ),
                          // TextField(
                          //   enabled: widget.isAdded!
                          // ? widget.isAdded
                          // : isEdited,
                          //   controller: _pendidikanController,
                          //   decoration: InputDecoration(
                          //     hintText: "Input Pendidikan",
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
                              'Jenis Pekerjaan',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10.0), // Radius
                            ),
                            child: IgnorePointer(
                              ignoring: widget.isAdded! ? isEdited : !isEdited,
                              child: DropdownButtonFormField<String>(
                                // DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedPekerjaan,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text(
                                      "Pilih Jenis Pekerjaan",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ...statusPekerjaan
                                      .map((Map<String, dynamic> option) {
                                    return DropdownMenuItem<String>(
                                      // value: option,
                                      value: option['id'].toString(),
                                      child: Text(
                                        option['pekerjaan'].toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (String? newValue) {
                                  // onChanged: (Map<String, dynamic>? newValue) {
                                  setState(() {
                                    selectedPekerjaan =
                                        newValue ?? ''; // Default jika null
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
                                  isDense: true,
                                  filled: true,
                                  fillColor: Color(0xFFF6F6F6),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: _isSubmitted
                                        ? _validateDropdown(
                                                    selectedPekerjaan!) !=
                                                ""
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  suffixIcon: _isSubmitted
                                      ? _validateDropdown(selectedPekerjaan!) !=
                                              ""
                                          ? null
                                          : Icon(
                                              Icons.error,
                                              color: AppColors.dangerColor,
                                            )
                                      : null,
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          // TextField(
                          //   enabled: widget.isAdded!
                          // ? widget.isAdded
                          // : isEdited,
                          //   controller: _pekerjaanController,
                          //   decoration: InputDecoration(
                          //     hintText: "Input Jenis Pekerjaan",
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
                              'Status Pernikahan',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10.0), // Radius
                            ),
                            child: IgnorePointer(
                              ignoring: widget.isAdded! ? isEdited : !isEdited,
                              child: DropdownButtonFormField<String>(
                                // DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedPernikahan,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text(
                                      "Pilih Status",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ...statusPernikahan
                                      .map((Map<String, dynamic> option) {
                                    return DropdownMenuItem<String>(
                                      // value: option,
                                      value: option['id'].toString(),
                                      child: Text(
                                        option['nmStatus'].toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (String? newValue) {
                                  // onChanged: (Map<String, dynamic>? newValue) {
                                  setState(() {
                                    selectedPernikahan =
                                        newValue ?? ''; // Default jika null
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
                                  isDense: true,
                                  filled: true,
                                  fillColor: Color(0xFFF6F6F6),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: _isSubmitted
                                        ? _validateDropdown(
                                                    selectedPernikahan!) !=
                                                ""
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  suffixIcon: _isSubmitted
                                      ? _validateDropdown(
                                                  selectedPernikahan!) !=
                                              ""
                                          ? null
                                          : Icon(
                                              Icons.error,
                                              color: AppColors.dangerColor,
                                            )
                                      : null,
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Status Hubungan Dalam Keluarga',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10.0), // Radius
                            ),
                            child: IgnorePointer(
                              ignoring: widget.isAdded! ? isEdited : !isEdited,
                              child: DropdownButtonFormField<String>(
                                // DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedHubungan,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text(
                                      "Pilih Hubungan ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ...statusHubungan
                                      .map((Map<String, dynamic> option) {
                                    return DropdownMenuItem<String>(
                                      // value: option,
                                      value: option['id'].toString(),
                                      child: Text(
                                        option['nmHubungan'].toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (String? newValue) {
                                  // onChanged: (Map<String, dynamic>? newValue) {
                                  setState(() {
                                    selectedHubungan =
                                        newValue ?? ''; // Default jika null
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
                                  isDense: true,
                                  filled: true,
                                  fillColor: Color(0xFFF6F6F6),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: _isSubmitted
                                        ? _validateDropdown(
                                                    selectedHubungan!) !=
                                                ""
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  suffixIcon: _isSubmitted
                                      ? _validateDropdown(selectedHubungan!) !=
                                              ""
                                          ? null
                                          : Icon(
                                              Icons.error,
                                              color: AppColors.dangerColor,
                                            )
                                      : null,
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          // TextField(
                          // enabled: widget.isAdded!
                          // ? widget.isAdded
                          // : isEdited,
                          //   controller: _hubunganController,
                          //   decoration: InputDecoration(
                          //     hintText: "Input Status Hubungan Dalam Keluarga",
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
                              'Kewarganegaraan',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10.0), // Radius
                            ),
                            child: IgnorePointer(
                              ignoring: widget.isAdded! ? isEdited : !isEdited,
                              child: DropdownButtonFormField<String>(
                                // DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedKewarganegaraan,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "",
                                    child: Text(
                                      "Pilih Kewarganegaraan ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ...statusKewarganegaraan
                                      .map((Map<String, dynamic> option) {
                                    return DropdownMenuItem<String>(
                                      // value: option,
                                      value: option['id'].toString(),
                                      child: Text(
                                        option['nmKewarganegaraan'].toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (String? newValue) {
                                  // onChanged: (Map<String, dynamic>? newValue) {
                                  setState(() {
                                    selectedKewarganegaraan =
                                        newValue ?? ''; // Default jika null
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
                                  isDense: true,
                                  filled: true,
                                  fillColor: Color(0xFFF6F6F6),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: _isSubmitted
                                        ? _validateDropdown(
                                                    selectedKewarganegaraan!) !=
                                                ""
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.red)
                                        : BorderSide.none,
                                  ),
                                  suffixIcon: _isSubmitted
                                      ? _validateDropdown(
                                                  selectedKewarganegaraan!) !=
                                              ""
                                          ? null
                                          : Icon(
                                              Icons.error,
                                              color: AppColors.dangerColor,
                                            )
                                      : null,
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          // TextFormField(
                          //   controller: _kwnController,
                          //   enabled:
                          //       widget.isAdded! ? widget.isAdded : isEdited,
                          //   validator: (value) {
                          //     if (_isSubmitted) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Harus diisi';
                          //       }
                          //     }
                          //     return null;
                          //   },
                          //   decoration: InputDecoration(
                          //     hintText: "Input Kewarganegaraan",
                          //     hintStyle: GoogleFonts.poppins(
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w500,
                          //         color: const Color(0xFFB7B7B7)),
                          //     filled: true,
                          //     fillColor: const Color(0xFFF6F6F6),
                          //     errorBorder: OutlineInputBorder(
                          //       borderSide: _isSubmitted
                          //           ? _validateTextField(_kwnController.text) !=
                          //                   ''
                          //               ? BorderSide.none
                          //               : BorderSide(color: Colors.red)
                          //           : BorderSide.none,
                          //     ),
                          //     suffixIcon: _isSubmitted
                          //         ? _validateTextField(_kwnController.text) !=
                          //                 ''
                          //             ? null
                          //             : Icon(
                          //                 Icons.error,
                          //                 color: AppColors.dangerColor,
                          //               )
                          //         : null,
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
                              'Nama Ayah',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            controller: _ayahController,
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
                              hintText: "Input Nama Ayah",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB7B7B7)),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              errorBorder: OutlineInputBorder(
                                borderSide: _isSubmitted
                                    ? _validateTextField(
                                                _ayahController.text) !=
                                            ''
                                        ? BorderSide.none
                                        : BorderSide(color: Colors.red)
                                    : BorderSide.none,
                              ),
                              suffixIcon: _isSubmitted
                                  ? _validateTextField(_ayahController.text) !=
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
                              contentPadding: const EdgeInsets.all(12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                            child: Text(
                              'Nama Ibu',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            controller: _ibuController,
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
                              hintText: "Input Nama Ibu",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB7B7B7)),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              errorBorder: OutlineInputBorder(
                                borderSide: _isSubmitted
                                    ? _validateTextField(_ibuController.text) !=
                                            ''
                                        ? BorderSide.none
                                        : BorderSide(color: Colors.red)
                                    : BorderSide.none,
                              ),
                              suffixIcon: _isSubmitted
                                  ? _validateTextField(_ibuController.text) !=
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
                              contentPadding: const EdgeInsets.all(12.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 0.0),
                            child: Text(
                              'Status Yatim Piatu',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Radio(
                                    // title: Text('Option 1'),
                                    value: '0',
                                    groupValue: selectedOption,
                                    onChanged: isEdited
                                        ? handleRadioValueChanged
                                        : widget.isAdded!
                                            ? handleRadioValueChanged
                                            : null,
                                  ),
                                  Text(
                                    'Ya',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF2E2E2E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    // title: Text('Option 1'),
                                    value: '1',
                                    groupValue: selectedOption,
                                    onChanged: isEdited
                                        ? handleRadioValueChanged
                                        : widget.isAdded!
                                            ? handleRadioValueChanged
                                            : null,
                                  ),
                                  Text(
                                    'Tidak',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF2E2E2E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          InkWell(
                            onTap: () async {
                              if (widget.isAdded!) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PsksPage(
                                            dataPsks: receivedData,
                                          )),
                                );

                                if (result != null) {
                                  setState(() {
                                    receivedData = result;
                                  });
                                }
                              } else if (isEdited) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PsksPage(
                                            dataPsks: receivedData,
                                          )),
                                );

                                if (result != null) {
                                  setState(() {
                                    receivedData = result;
                                  });
                                }
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const PsksPage()),
                              // );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: receivedData.isEmpty ? false : true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    onChanged: (value) async {
                                      if (widget.isAdded!) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PsksPage(
                                                    dataPsks: receivedData,
                                                  )),
                                        );

                                        if (result != null) {
                                          setState(() {
                                            receivedData = result;
                                          });
                                        }
                                      } else if (isEdited) {
                                        // print('data yg dikirim $receivedData');
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PsksPage(
                                                    dataPsks: receivedData,
                                                  )),
                                        );

                                        if (result != null) {
                                          setState(() {
                                            receivedData = result;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PSKS',
                                        // maxLines: 1,
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF7E7E7E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Potensi dan Sumber Kesejahteraan Sosial',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF7E7E7E),
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.only(left: 22.0, right: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: BlocConsumer<PsksCubit, PsksState>(
                                listener: (context, state) {
                                  if (state is DataPsksSuccess) {
                                    setState(() {
                                      psksData.addAll(state.data['data']);
                                      for (var item in state.data['data']) {
                                        receivedData.add(
                                          {
                                            "id": item['id_jenis'],
                                            "nmJenis": item['jenis_psks'],
                                            "isChecked": true
                                          },
                                        );
                                      }
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  if (receivedData.isNotEmpty) {
                                    return Row(
                                      children: [
                                        Column(
                                          children: [
                                            for (var item in receivedData)
                                              Container(
                                                width: 2,
                                                height: 20,
                                                color: Color(0xFF4FC4CF),
                                              ),
                                          ],
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var item in receivedData)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0),
                                                  child: Text(
                                                    // '• 2 $dataPsks',
                                                    '• ${item["nmJenis"]}',
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF4FC4CF),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (state is DataPsksSuccess) {
                                    if (state.data['data'] != null) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: state.data['data'].length,
                                        itemBuilder: ((context, index) {
                                          if (state.data['data'][index]
                                                  ['nik'] ==
                                              widget.noNik) {
                                            return Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    // for (var item in receivedData)
                                                    Container(
                                                      width: 2,
                                                      height: 20,
                                                      color: Color(0xFF4FC4CF),
                                                    ),
                                                  ],
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // for (var item in receivedData)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 6.0),
                                                        child: Text(
                                                          "• ${state.data['data'][index]['jenis_psks']}",
                                                          maxLines: 2,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Color(
                                                                      0xFF4FC4CF),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                  return Row(
                                    children: [
                                      Column(
                                        children: [
                                          for (var item in receivedData)
                                            Container(
                                              width: 2,
                                              height: 20,
                                              color: Color(0xFF4FC4CF),
                                            ),
                                        ],
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var item in receivedData)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0),
                                                child: Text(
                                                  // '• 2 $dataPsks',
                                                  '• ${item["nmJenis"]}',
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      color: Color(0xFF4FC4CF),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (widget.isAdded!) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PpksPage(
                                            dataPpks: receivedDataPPKS,
                                          )),
                                );

                                if (result != null) {
                                  setState(() {
                                    receivedDataPPKS = result;
                                  });
                                }
                              } else if (isEdited) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PpksPage(
                                            dataPpks: receivedDataPPKS,
                                          )),
                                );

                                if (result != null) {
                                  setState(() {
                                    receivedDataPPKS = result;
                                  });
                                }
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const PpksPage()),
                              // );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value:
                                        receivedDataPPKS.isEmpty ? false : true,
                                    // value:
                                    //     receivedDataPPKS.isEmpty ? false : true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    onChanged: (value) async {
                                      if (widget.isAdded!) {
                                        // print(receivedDataPPKS);
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PpksPage(
                                                    dataPpks: receivedDataPPKS,
                                                  )),
                                        );

                                        if (result != null) {
                                          setState(() {
                                            receivedDataPPKS = result;
                                          });
                                        }
                                      } else if (isEdited) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PpksPage(
                                                    dataPpks: receivedDataPPKS,
                                                  )),
                                        );

                                        if (result != null) {
                                          setState(() {
                                            receivedDataPPKS = result;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PPKS',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF7E7E7E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Pemerlu Pelayanan Kesejahteraan Sosial',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF7E7E7E),
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 22.0, right: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: BlocConsumer<PpksCubit, PpksState>(
                                listener: (context, state) {
                                  if (state is DataPpksSuccess) {
                                    setState(() {
                                      ppksData.addAll(state.data['data']);
                                      // print('data ppks $ppksData');
                                      for (var item in state.data['data']) {
                                        receivedDataPPKS.add(
                                          {
                                            "id": item['id_jenis'],
                                            "nmJenis": item['jenis_ppks'],
                                            "isChecked": true
                                          },
                                        );
                                      }
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  var dataPsks = state is DataPsksFailure;

                                  if (receivedDataPPKS.isNotEmpty) {
                                    return Row(
                                      children: [
                                        Column(
                                          children: [
                                            for (var item in receivedDataPPKS)
                                              Container(
                                                width: 2,
                                                height: 20,
                                                color: Color(0xFF4FC4CF),
                                              ),
                                          ],
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var item in receivedDataPPKS)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0),
                                                  child: Text(
                                                    // '• 2 $dataPsks',
                                                    '• ${item["nmJenis"]}',
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF4FC4CF),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (state is DataPpksSuccess) {
                                    if (state.data['data'] != null) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: state.data['data'].length,
                                        itemBuilder: ((context, index) {
                                          if (state.data['data'][index]
                                                  ['nik'] ==
                                              widget.noNik) {
                                            return Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    // for (var item in receivedData)
                                                    Container(
                                                      width: 2,
                                                      height: 20,
                                                      color: Color(0xFF4FC4CF),
                                                    ),
                                                  ],
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // for (var item in receivedData)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 6.0),
                                                        child: Text(
                                                          "• ${state.data['data'][index]['jenis_ppks']}",
                                                          maxLines: 2,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Color(
                                                                      0xFF4FC4CF),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                  return Row(
                                    children: [
                                      Column(
                                        children: [
                                          for (var item in receivedDataPPKS)
                                            Container(
                                              width: 2,
                                              height: 20,
                                              color: Color(0xFF4FC4CF),
                                            ),
                                        ],
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var item in receivedDataPPKS)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0),
                                                child: Text(
                                                  '• ${item["nmJenis"]}',
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      color: Color(0xFF4FC4CF),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 22.0, right: 16.0),
                          //   child: Container(
                          //     width: double.infinity,
                          //     child: Row(
                          //       children: [
                          //         Column(
                          //           children: [
                          //             for (var item in receivedDataPPKS)
                          //               Container(
                          //                 width: 2,
                          //                 height: 20,
                          //                 color: Color(0xFF4FC4CF),
                          //               ),
                          //           ],
                          //         ),
                          //         Flexible(
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               for (var item in receivedDataPPKS)
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.only(left: 6.0),
                          //                   child: Text(
                          //                     '• ${item["nmJenis"]}',
                          //                     maxLines: 2,
                          //                     style: GoogleFonts.poppins(
                          //                         color: Color(0xFF4FC4CF),
                          //                         fontSize: 12,
                          //                         fontWeight: FontWeight.w400),
                          //                   ),
                          //                 ),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          InkWell(
                            onTap: () async {
                              if (widget.isAdded!) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BansosPage(
                                            dataBansos: receivedDataBansos,
                                          )),
                                );

                                if (result != null) {
                                  setState(() {
                                    receivedDataBansos = result;
                                  });
                                }
                              } else if (isEdited) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BansosPage(
                                            dataBansos: receivedDataBansos,
                                          )),
                                );

                                if (result != null) {
                                  setState(() {
                                    receivedDataBansos = result;
                                  });
                                }
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const BansosPage()),
                              // );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: receivedDataBansos.isEmpty
                                        ? false
                                        : true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    onChanged: (value) async {
                                      if (widget.isAdded!) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BansosPage(
                                                    dataBansos:
                                                        receivedDataBansos,
                                                  )),
                                        );

                                        if (result != null) {
                                          setState(() {
                                            receivedDataBansos = result;
                                          });
                                        }
                                      } else if (isEdited) {
                                        print(
                                            'data bansos klik $receivedDataBansos');
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BansosPage(
                                                    dataBansos:
                                                        receivedDataBansos,
                                                  )),
                                        );

                                        if (result != null) {
                                          setState(() {
                                            receivedDataBansos = result;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  Text(
                                    'Penerima Bantuan Sosial',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF7E7E7E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 22.0, right: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: BlocConsumer<BansosCubit, BansosState>(
                                listener: (context, state) {
                                  if (state is DataBansosSuccess) {
                                    setState(() {
                                      bansosData.addAll(state.data['data']);
                                      // print('data bansos $bansosData');
                                      for (var item in state.data['data']) {
                                        receivedDataBansos.add(
                                          {
                                            "id": item['id_jenis'],
                                            "type": item['jenis_bansos'],
                                            "nmJenis": item['nama_bansos'],
                                            "isChecked": true
                                          },
                                        );
                                      }
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  var dataBansos = state is DataBansosFailure;

                                  if (receivedDataBansos.isNotEmpty) {
                                    return Row(
                                      children: [
                                        Column(
                                          children: [
                                            for (var item in receivedDataBansos)
                                              Container(
                                                width: 2,
                                                height: 20,
                                                color: Color(0xFF4FC4CF),
                                              ),
                                          ],
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var item
                                                  in receivedDataBansos)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0),
                                                  child: Text(
                                                    // '• 2 $dataPsks',
                                                    '• ${item["nmJenis"]} "${item["type"]}"',
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFF4FC4CF),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (state is DataBansosSuccess) {
                                    if (state.data['data'] != null) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: state.data['data'].length,
                                        itemBuilder: ((context, index) {
                                          if (state.data['data'][index]
                                                  ['nomor_nik'] ==
                                              widget.noNik) {
                                            return Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    // for (var item in receivedData)
                                                    Container(
                                                      width: 2,
                                                      height: 20,
                                                      color: Color(0xFF4FC4CF),
                                                    ),
                                                  ],
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // for (var item in receivedData)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 6.0),
                                                        child: Text(
                                                          '• ${state.data['data'][index]['nama_bansos']} "${state.data['data'][index]['jenis_bansos']}"',
                                                          maxLines: 2,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Color(
                                                                      0xFF4FC4CF),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                  return Row(
                                    children: [
                                      Column(
                                        children: [
                                          for (var item in receivedDataBansos)
                                            Container(
                                              width: 2,
                                              height: 20,
                                              color: Color(0xFF4FC4CF),
                                            ),
                                        ],
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var item in receivedDataBansos)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0),
                                                child: Text(
                                                  '• ${item["nmJenis"]}',
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      color: Color(0xFF4FC4CF),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),

                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 22.0, right: 16.0),
                          //   child: Container(
                          //     width: double.infinity,
                          //     child: Row(
                          //       children: [
                          //         Column(
                          //           children: [
                          //             for (var item in receivedDataBansos)
                          //               Container(
                          //                 width: 2,
                          //                 height: 20,
                          //                 color: Color(0xFF4FC4CF),
                          //               ),
                          //           ],
                          //         ),
                          //         Flexible(
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               for (var item in receivedDataBansos)
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       left: 6.0),
                          //                   child: Text(
                          //                     '• ${item["nmJenis"]}',
                          //                     maxLines: 2,
                          //                     style: GoogleFonts.poppins(
                          //                         color: Color(0xFF4FC4CF),
                          //                         fontSize: 12,
                          //                         fontWeight: FontWeight.w400),
                          //                   ),
                          //                 ),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 100),
                          // if (widget.isAdded!)
                          //   InkWell(
                          //     onTap: () async {
                          //       String lokasi = _lokasiController.text.trim();
                          //       String kk = _kkController.text.trim();
                          //       String nik = _nikController.text.trim();
                          //       String nama = _namaController.text.trim();
                          //       String jk = _jkController.text.trim();
                          //       String tempat = _tempatController.text.trim();
                          //       String tanggal = _tanggalController.text.trim();
                          //       String goldar = _goldarController.text.trim();
                          //       String agama = _agamaController.text.trim();
                          //       String pendidikan =
                          //           _pendidikanController.text.trim();
                          //       String pekerjaan =
                          //           _pekerjaanController.text.trim();
                          //       String pernikahan =
                          //           _pernikahanController.text.trim();
                          //       String hubungan =
                          //           _hubunganController.text.trim();
                          //       String kwn = _kwnController.text.trim();
                          //       String ayah = _ayahController.text.trim();
                          //       String ibu = _ibuController.text.trim();
                          //       String yatimpiatu =
                          //           _yatimpiatuController.text.trim();
                          //       String usaha = _usahaController.text.trim();
                          //       final data =
                          //           await SharedPreferencesUtil.getData();
                          //       kependudukanCubit.postAnggotaKeluarga(
                          //           data['data']['token'],
                          //           kk,
                          //           nik,
                          //           nama,
                          //           '1',
                          //           tempat,
                          //           tanggal,
                          //           selectedAgama,
                          //           selectedPendidikan,
                          //           selectedPekerjaan,
                          //           selectedPernikahan,
                          //           selectedHubungan,
                          //           selectedKewarganegaraan,
                          //           ayah,
                          //           ibu,
                          //           selectedGoldar,
                          //           selectedOption,
                          //           "2");

                          //       for (var item in receivedData) {
                          //         kependudukanCubit.postPSKS(
                          //             data['data']['token'], nik, item['id']);
                          //         // print(item);
                          //       }
                          //       for (var item in receivedDataPPKS) {
                          //         kependudukanCubit.postPPKS(
                          //             data['data']['token'], nik, item['id']);
                          //         // print(item);
                          //       }
                          //       for (var item in receivedDataBansos) {
                          //         kependudukanCubit.postBansos(
                          //             data['data']['token'], nik, item['id']);
                          //         // print(item);
                          //       }
                          //     },
                          //     child: Container(
                          //       width: MediaQuery.of(context).size.width,
                          //       height: 40,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(45.0),
                          //         gradient: const LinearGradient(
                          //           colors: [
                          //             Color(0xFF4FC4CF),
                          //             Color(0xFF4FC4CF)
                          //           ],
                          //           begin: Alignment.topCenter,
                          //           end: Alignment.bottomCenter,
                          //         ),
                          //       ),
                          //       child: const Center(
                          //           child: Text(
                          //         'SUBMIT',
                          //         style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.bold),
                          //       )),
                          //     ),
                          //   )
                          // else if (isEdited)
                          //   InkWell(
                          //     onTap: () async {
                          //       String lokasi = _lokasiController.text.trim();
                          //       String kk = _kkController.text.trim();
                          //       String nik = _nikController.text.trim();
                          //       String nama = _namaController.text.trim();
                          //       String jk = _jkController.text.trim();
                          //       String tempat = _tempatController.text.trim();
                          //       String tanggal = _tanggalController.text.trim();
                          //       String goldar = _goldarController.text.trim();
                          //       String agama = _agamaController.text.trim();
                          //       String pendidikan =
                          //           _pendidikanController.text.trim();
                          //       String pekerjaan =
                          //           _pekerjaanController.text.trim();
                          //       String pernikahan =
                          //           _pernikahanController.text.trim();
                          //       String hubungan =
                          //           _hubunganController.text.trim();
                          //       String kwn = _kwnController.text.trim();
                          //       String ayah = _ayahController.text.trim();
                          //       String ibu = _ibuController.text.trim();
                          //       String yatimpiatu =
                          //           _yatimpiatuController.text.trim();
                          //       String usaha = _usahaController.text.trim();
                          //       final data =
                          //           await SharedPreferencesUtil.getData();
                          //       kependudukanCubit.editAnggotaKeluarga(
                          //           data['data']['token'],
                          //           widget.idAnggota.toString(),
                          //           kk,
                          //           nik,
                          //           nama,
                          //           selectedValue,
                          //           tempat,
                          //           tanggal,
                          //           agama,
                          //           pendidikan,
                          //           pekerjaan,
                          //           selectedPernikahan,
                          //           selectedHubungan,
                          //           selectedKewarganegaraan,
                          //           ayah,
                          //           ibu,
                          //           goldar,
                          //           selectedOption,
                          //           "2",
                          //           '1');
                          //       // print('${widget.idPic}');
                          //       if (receivedData.isNotEmpty) {
                          //         for (var item in psksData) {
                          //           if (item['nik'] == widget.noNik) {
                          //             psksCubit.deletePSKS(
                          //                 data['data']['token'], item['id']);
                          //           }
                          //         }
                          //       }
                          //       for (var item in receivedData) {
                          //         kependudukanCubit.postPSKS(
                          //             data['data']['token'], nik, item['id']);
                          //         // print(item);
                          //       }
                          //       if (receivedDataPPKS.isNotEmpty) {
                          //         for (var item in ppksData) {
                          //           if (item['nik'] == widget.noNik) {
                          //             ppksCubit.deletePPKS(
                          //                 data['data']['token'], item['id']);
                          //           }
                          //         }
                          //       }
                          //       for (var item in receivedDataPPKS) {
                          //         kependudukanCubit.postPPKS(
                          //             data['data']['token'], nik, item['id']);
                          //         // print(item);
                          //       }
                          //       // for (var item in receivedDataBansos) {
                          //       //   kependudukanCubit.postBansos(
                          //       //       data['data']['token'], nik, item['id']);
                          //       //   // print(item);
                          //       // }
                          //     },
                          //     child: Container(
                          //       width: MediaQuery.of(context).size.width,
                          //       height: 40,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(45.0),
                          //         gradient: const LinearGradient(
                          //           colors: [
                          //             Color(0xFF4FC4CF),
                          //             Color(0xFF4FC4CF)
                          //           ],
                          //           begin: Alignment.topCenter,
                          //           end: Alignment.bottomCenter,
                          //         ),
                          //       ),
                          //       child: const Center(
                          //           child: Text(
                          //         'SUBMIT',
                          //         style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.bold),
                          //       )),
                          //     ),
                          //   )
                          // else
                          //   SizedBox(),
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
                final data = await SharedPreferencesUtil.getData();
                String lokasi = _lokasiController.text.trim();
                String kk = _kkController.text.trim();
                String nik = _nikController.text.trim();
                String nama = _namaController.text.trim();
                String jk = _jkController.text.trim();
                String tempat = _tempatController.text.trim();
                String tanggal = _tanggalController.text.trim();
                String goldar = _goldarController.text.trim();
                String agama = _agamaController.text.trim();
                String pendidikan = _pendidikanController.text.trim();
                String pekerjaan = _pekerjaanController.text.trim();
                String pernikahan = _pernikahanController.text.trim();
                String hubungan = _hubunganController.text.trim();
                String kwn = _kwnController.text.trim();
                String ayah = _ayahController.text.trim();
                String ibu = _ibuController.text.trim();
                String yatimpiatu = _yatimpiatuController.text.trim();
                String usaha = _usahaController.text.trim();
                setState(() {
                  _isSubmitted = true;
                });
                if (_formKey.currentState!.validate()) {
                  if (widget.isAdded!) {
                    kependudukanCubit.postAnggotaKeluarga(
                        data['data']['token'],
                        kk,
                        nik,
                        nama,
                        selectedValue,
                        tempat,
                        tanggal,
                        selectedAgama,
                        selectedPendidikan,
                        selectedPekerjaan,
                        selectedPernikahan,
                        selectedHubungan,
                        selectedKewarganegaraan,
                        ayah,
                        ibu,
                        selectedGoldar,
                        selectedOption,
                        "2");

                    for (var item in receivedData) {
                      kependudukanCubit.postPSKS(
                          data['data']['token'], nik, item['id']);
                      // print(item);
                    }
                    for (var item in receivedDataPPKS) {
                      kependudukanCubit.postPPKS(
                          data['data']['token'], nik, item['id']);
                      // print(item);
                    }
                    for (var item in receivedDataBansos) {
                      kependudukanCubit.postBansos(
                          data['data']['token'], nik, item['id']);
                      // print(item);
                    }
                  } else if (isEdited) {
                    kependudukanCubit.editAnggotaKeluarga(
                        data['data']['token'],
                        widget.idAnggota.toString(),
                        kk,
                        nik,
                        nama,
                        selectedValue,
                        tempat,
                        tanggal,
                        selectedAgama,
                        selectedPendidikan,
                        selectedPekerjaan,
                        selectedPernikahan,
                        selectedHubungan,
                        selectedKewarganegaraan,
                        ayah,
                        ibu,
                        selectedGoldar,
                        selectedOption,
                        "2",
                        '1');
                    // print('${widget.idPic}');
                    if (receivedData.isNotEmpty) {
                      for (var item in psksData) {
                        if (item['nik'] == widget.noNik) {
                          psksCubit.deletePSKS(
                              data['data']['token'], item['id']);
                        }
                      }
                    }
                    for (var item in receivedData) {
                      kependudukanCubit.postPSKS(
                          data['data']['token'], nik, item['id']);
                      // print(item);
                    }
                    if (receivedDataPPKS.isNotEmpty) {
                      for (var item in ppksData) {
                        if (item['nik'] == widget.noNik) {
                          ppksCubit.deletePPKS(
                              data['data']['token'], item['id']);
                        }
                      }
                    }
                    for (var item in receivedDataPPKS) {
                      kependudukanCubit.postPPKS(
                          data['data']['token'], nik, item['id']);
                      // print(item);
                    }
                    if (receivedDataBansos.isNotEmpty) {
                      for (var item in bansosData) {
                        print('bansos adalah ${item}');
                        //     // if (item['nomor_nik'] == widget.noNik) {
                        bansosCubit.deleteBansos(
                            data['data']['token'], item['id']);
                        // }
                      }
                    }
                    for (var item in receivedDataBansos) {
                      kependudukanCubit.postBansos(
                          data['data']['token'], nik, item['id']);
                      // print(item);
                    }
                    // for (var item in receivedDataPPKS) {
                    //   kependudukanCubit.postPPKS(
                    //       data['data']['token'], nik, item['id']);
                    //   // print(item);
                    // }
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
                                  _dialogDelete(context, kependudukanCubit,
                                      psksCubit, ppksCubit, bansosCubit);
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

  void _dialogResponse(BuildContext context, bool status) {
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
            height: status ? height * 0.15 : height * 0.2,
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
                      : 'Periksa kembali data yang dimasukkan, pastikan data telah sesuai atau nik tersebut sudah tersimpan.',
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
                  Navigator.of(context).pop();
                  Navigator.pop(context, status);
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

  void _dialogDelete(BuildContext context, KependudukanCubit kependudukanCubit,
      PsksCubit psksCubit, PpksCubit ppksCubit, BansosCubit bansosCubit) {
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
                  kependudukanCubit.deleteAnggotaKeluarga(
                    user['data']['token'],
                    widget.idAnggota.toString(),
                  );
                  if (receivedData.isNotEmpty) {
                    for (var item in psksData) {
                      if (item['nik'] == widget.noNik) {
                        psksCubit.deletePSKS(user['data']['token'], item['id']);
                      }
                    }
                  }
                  if (receivedDataPPKS.isNotEmpty) {
                    for (var item in ppksData) {
                      if (item['nik'] == widget.noNik) {
                        ppksCubit.deletePPKS(user['data']['token'], item['id']);
                      }
                    }
                  }
                  if (receivedDataBansos.isNotEmpty) {
                    for (var item in bansosData) {
                      if (item['nik'] == widget.noNik) {
                        bansosCubit.deleteBansos(
                            user['data']['token'], item['id']);
                      }
                    }
                  }
                });
                Navigator.of(context).pop();
                Navigator.pop(context, true);
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
                      : 'Periksa kembali data yang dimasukkan, pastikan data telah sesuai dan benar',
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
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
