import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/auth/auth_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kepala/kepala_keluarga_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kepala/kepala_keluarga_state.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/utils/app_colors.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/kepala/kependudukan_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/login/login_page.dart';

class KepalaKeluargaPage extends StatefulWidget {
  final double? lat;
  final double? long;
  KepalaKeluargaPage({this.lat, this.long, super.key});

  @override
  State<KepalaKeluargaPage> createState() => _KepalaKeluargaPageState();
}

class _KepalaKeluargaPageState extends State<KepalaKeluargaPage> {
  bool _isLoading = false;

  var name = "";
  var role = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getKepalaKeluarga();
  }

  Future getUserData() async {
    final data = await SharedPreferencesUtil.getData();
    setState(() {
      name = data['data']['name'];
      role = data['data']['role'];
    });
    return data;
  }

  Future<void> getProvinsi(
    bool isAdded,
    int idKK,
    String noKK,
    String namaKK,
    String alamat,
    String rt,
    String rw,
    String selectedProvince,
    String selectedKota,
    String selectedKecamatan,
    String selectedKelurahan,
    int idObjek,
    String idPic,
  ) async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<ProvinsiCubit>().fetchProvinsi(data['data']['token']);
        if (noKK.isNotEmpty || noKK != '') {
          context.read<KabupatenCubit>().fetchKabupatenByProvinsiId(
              selectedProvince, data['data']['token']);
          context
              .read<KecamatanCubit>()
              .fetchKecamatanByKabupatenId(selectedKota, data['data']['token']);
          context.read<KelurahanCubit>().fetchKelurahanByKecamatanId(
              selectedKecamatan, data['data']['token']);

          // context
          //     .read<LokasiCubit>()
          //     .getLokasiObject(data['data']['token'], idObjek.toString());
        }
      });
      print('id lokasi $idObjek');
    }
    setState(() {
      _isLoading = !_isLoading;
    });
    Future.delayed(Duration(milliseconds: 1500), () async {
      setState(() {
        _isLoading = !_isLoading;
      });
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KependudukanPage(
            isAdded: isAdded,
            idKepalaKeluarga: idKK,
            noKK: noKK,
            namaKepala: namaKK,
            alamat: alamat,
            rt: rt,
            rw: rw,
            kodeProv: selectedProvince,
            kodeKota: selectedKota,
            kodeKec: selectedKecamatan,
            kodeKel: selectedKelurahan,
            lokasiObjek: idObjek,
            idPic: idPic,
          ),
        ),
      );
      if (result != null) {
        setState(() {
          getKepalaKeluarga();
        });
      }
    });
  }

  Future<void> getKepalaKeluarga() async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context
            .read<KepalaKeluargaCubit>()
            .loadKepalaKeluarga(data['data']['token'], data['data']['user_id']);
      });
    }
  }

  Future<void> _refresh() async {
    // Simulate a delay for data fetching
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getKepalaKeluarga();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final kepalaCubit = context.read<KepalaKeluargaCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: _refresh,
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
                      'Informasi data daftar \nkepala keluarga yang tersimpan',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: screenHeight * 0.3,
                left: 0,
                right: 0,
                bottom: 20,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        BlocConsumer<KepalaKeluargaCubit, KepalaKeluargaState>(
                      listener: (context, state) async {
                        if (state is ExpiredToken) {
                          await SharedPreferencesUtil.removeUser();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _dialogExpiredToken(context);
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is ExpiredToken) {
                          return Container(
                            child: ListView(
                              children: [
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Sesi anda sudah habis, harap ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()), // Gantilah dengan halaman yang sesuai
                                            (route) =>
                                                false, // Callback untuk menutup semua halaman saat ini
                                          );
                                        },
                                        child: Text(
                                          'login kembali',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (state is KepalaKeluargaLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is KepalaKeluargaLoaded) {
                          final data = state.data['data']['content'];
                          return data != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: data.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        getProvinsi(
                                          false,
                                          data[index]['id'],
                                          data[index]['nomor_kk'],
                                          data[index]['nama_kk'],
                                          data[index]['alamat'],
                                          data[index]['rt'].toString(),
                                          data[index]['rw'].toString(),
                                          data[index]['provinsi']['id']
                                              .toString(),
                                          data[index]['kota']['id'].toString(),
                                          data[index]['kecamatan']['id']
                                              .toString(),
                                          data[index]['kelurahan']['id']
                                              .toString(),
                                          data[index]['id_lokasi_objek'],
                                          data[index]['pic'],
                                        );
                                        // final result = await Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => KependudukanPage(
                                        //       idKepalaKeluarga: data[index]['id'],
                                        //       noKK: data[index]['nomor_kk'],
                                        //       namaKepala: data[index]['nama_kk'],
                                        //       alamat: data[index]['alamat_rt_rw'],
                                        //       kodeProv: data[index]['provinsi'],
                                        //       kodeKota: data[index]['kota'],
                                        //       kodeKec: data[index]['kecamatan'],
                                        //       kodeKel: data[index]['desa_kelurahan'],
                                        //       lokasiObjek: data[index]
                                        //           ['id_lokasi_objek'],
                                        //       idPic: data[index]['pic'],
                                        //     ),
                                        //   ),
                                        // );
                                        // if (result != null) {
                                        //   setState(() {
                                        //     getKepalaKeluarga();
                                        //   });
                                        // }
                                      },
                                      child: buildCardKK(
                                        context,
                                        data[index]['nomor_kk'].toString(),
                                        data[index]['nama_kk'].toString(),
                                        data[index]['alamat'] ?? '-',
                                      ),
                                    );
                                  }),
                                )
                              : Container(
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Belum ada data yang di input',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }
                        return Container(
                          child: Center(
                            child: Text(
                              '',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: _isLoading
                      ? Stack(
                          children: [
                            // Background gelap
                            ModalBarrier(
                              color: Colors.black.withOpacity(0.4),
                              dismissible: false,
                            ),

                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: floatinglocation,
      floatingActionButton: InkWell(
        onTap: () {
          getProvinsi(true, 0, '', '', '', '', '', '', '', '', '', 0, '');
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }

  Widget buildCardKK(
      BuildContext context, String kk, String nama, String alamat) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFe5e5e5),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0.5,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 0.3,
                child: Text(
                  'Kartu Keluarga',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                ':',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    kk,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: width * 0.3,
                child: Text(
                  'Kepala Keluarga',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                child: Text(
                  ':',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    nama,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.3,
                child: Text(
                  'Alamat',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                ':',
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    alamat,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: width,
            child: Text(
              'Selengkapnya',
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
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
                Navigator.of(context).pop();
                // Navigator.of(context, rootNavigator: true).pop();

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
}
