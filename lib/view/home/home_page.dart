import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/auth/auth_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/utils/app_colors.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/faskes/faskes.dart';
import 'package:sistem_pendataan_kewilayahan/view/input_kependudukan_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/kepala/kepala_keluarga_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/kepala/kependudukan_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/login/login_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/olahraga/olahraga_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/pohon/pohon_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/tps_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _lat = 0;
  double _lng = 0;

  var name = "";
  var role = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    Future.delayed(Duration.zero, () {
      // getLocation();
      checkAndGetLocation();
    });
  }

  Future getUserData() async {
    final data = await SharedPreferencesUtil.getData();
    setState(() {
      name = data['data']['name'];
      role = data['data']['role'];
    });
    return data;
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

      _lat = position.latitude;
      _lng = position.longitude;

      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

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

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KepalaKeluargaPage(
                                                lat: _lat,
                                                long: _lng,
                                              )),
                                      // KependudukanPage()),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_kependudukan.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Kependudukan',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PohonPage()),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_pohon.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Data Pohon',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TpsPage()),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_garbagetruck.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          'Tempat Pembuangan Sampah',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF000000),
                                              fontSize: 10,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             KependudukanPage()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Coming Soon!'),
                                        duration: Duration(
                                            seconds: 1), // Durasi snackbar
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_fasiba.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nIbadah',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const FaskesPage(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_faskes.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nKesehatan',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Coming Soon!'),
                                        duration: Duration(
                                            seconds: 1), // Durasi snackbar
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_faspen.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nPendidikan',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Coming Soon!'),
                                        duration: Duration(
                                            seconds: 1), // Durasi snackbar
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_fasbel.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nPerbelanjaan',
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OlahragaPage(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_fasola.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nOlahraga',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Coming Soon!'),
                                        duration: Duration(
                                            seconds: 1), // Durasi snackbar
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_faskea.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nKeamanan',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Coming Soon!'),
                                        duration: Duration(
                                            seconds: 1), // Durasi snackbar
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_fasrek.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nRekreasi',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Coming Soon!'),
                                        duration: Duration(
                                            seconds: 1), // Durasi snackbar
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_fasmain.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nBermain',
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Coming Soon!'),
                                        duration: Duration(
                                            seconds: 1), // Durasi snackbar
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        child: Card(
                                          elevation: 0,
                                          color: Color(0xFFDAF5F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Ganti angka ini sesuai dengan radius yang Anda inginkan
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/icons/ic_fastrans.png',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Fasilitas\nTransportasi',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // child: Center(
                      //   child: Text(
                      //     'Kontainer 2',
                      //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: screenHeight * 0.26,
              right: 20,
              // left: 20,
              // bottom: 0,
              child: Image.asset(
                'assets/images/img_spk.png',
                width: 200,
                height: 200,
              )),
          Positioned(
            top: screenHeight * 0.05,
            right: 20,
            left: 20,
            // bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset(
                      'assets/icons/logo_sawargi.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SAWARGI',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10,
                            decoration:
                                TextDecoration.none, // Menghilangkan underline

                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'KOTA BANDUNG',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                            decoration:
                                TextDecoration.none, // Menghilangkan underline

                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.15,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        MaterialPageRoute(builder: (context) => LoginPage()),
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
            top: screenHeight * 0.2,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang',
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                      decoration:
                          TextDecoration.none, // Menghilangkan underline
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Sistem Pendataan\nKewilayahan\nKota Bandung',
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      decoration:
                          TextDecoration.none, // Menghilangkan underline

                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Data Pohon",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Tempat Tinggal",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Ibadah",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kesehatan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Kesehatan",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_pendidikan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Pendidikan",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Perbelanjaan",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Olahraga",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Keamanan",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Rekreasi",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Bermain",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 60,
//                             margin: EdgeInsets.only(top: 8),
//                             child: Card(
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/icons/ic_kependudukan.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "Fasilitas Transfortasi",
//                                             style: TextStyle(
//                                                 color: Color(0xFF000000),
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.keyboard_arrow_right,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
