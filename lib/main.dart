// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sistem_pendataan_kewilayahan/cubit/auth/auth_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/faskes/faskes_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kepala/kepala_keluarga_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/master/agama/agama_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/master/goldar/golongan_darah_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/master/hubungan/status_hubungan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/master/pendidikan/pendidikan_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/models/kependudukan.dart';
import 'package:sistem_pendataan_kewilayahan/utils/app_colors.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/home/home_page.dart';
import 'package:sistem_pendataan_kewilayahan/view/login/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await SharedPreferencesUtil.getData();

  runApp(MyApp(
    data: data,
  ));
}

class MyApp extends StatelessWidget {
  final dynamic? data;
  const MyApp({this.data, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Kependudukan _kep;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        // BlocProvider(
        //   create: (context) => KependudukanCubit(),
        // ),
        BlocProvider(create: (context) => KependudukanCubit()),
        BlocProvider(create: (context) => KepalaKeluargaCubit()),
        BlocProvider(create: (context) => LokasiCubit()),
        BlocProvider(create: (context) => PsksCubit()),
        BlocProvider(create: (context) => PpksCubit()),
        BlocProvider(create: (context) => BansosCubit()),
        BlocProvider(create: (context) => ProvinsiCubit()),
        BlocProvider(create: (context) => KabupatenCubit()),
        BlocProvider(create: (context) => KecamatanCubit()),
        BlocProvider(create: (context) => KelurahanCubit()),
        BlocProvider(create: (context) => FaskesCubit()),
        BlocProvider(create: (context) => GolonganDarahCubit()),
        BlocProvider(create: (context) => AgamaCubit()),
        BlocProvider(create: (context) => PendidikanCubit()),
        BlocProvider(create: (context) => StatusHubunganCubit()),
      ],
      child: MaterialApp(
        title: 'Sawargi Kota Bandung',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        // home: const LoginPage(),
      ),
    );
  }
}

class PickMapsPage extends StatefulWidget {
  final double? lat;
  final double? long;

  const PickMapsPage({this.lat, this.long, super.key});

  @override
  State<PickMapsPage> createState() => _PickMapsPageState();
}

class _PickMapsPageState extends State<PickMapsPage> {
  late double _lat;
  late double _lng;
  MapController _mapController = MapController();
  LatLng center = LatLng(0, 0); // Initial center
  double _currentZoom = 16.0; // Nilai zoom awal

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocation();
    _lat = widget.lat!;
    _lng = widget.long!;
    print('$_lat $_lng');
    center = LatLng(_lat, _lng);
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
        _lat = position.latitude;
        _lng = position.longitude;
        center = LatLng(position.latitude, position.latitude);
        _mapController.move(center, 16.0);
      });

      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Izin ditolak, Anda dapat memberi tahu pengguna untuk pergi ke pengaturan dan mengizinkan izin.
      openAppSettings();
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Izin diberikan, Anda dapat mengambil lokasi.
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // _latController.text = '${position.latitude}, ${position.longitude}';
      // _lngController.text = position.longitude.;
      setState(() {
        _lat = position.latitude;
        _lng = position.longitude;
        center = LatLng(position.latitude, position.latitude);
        _mapController.move(center, 16.0);
        print('posisi ${position.latitude} ${position.longitude}');
      });
      // print('Latitude: ${position.latitude}');
      // print('Longitude: ${position.longitude}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: center,
                zoom: _currentZoom,
                onTap: (tapPosition, point) {
                  // print(point);
                  setState(() {
                    _lat = point.latitude;
                    _lng = point.longitude;
                  });
                },
                onPositionChanged: (MapPosition position, bool hasGesture) {
                  // Update the marker position when the map is panned or zoomed
                  setState(() {
                    center = position.center!;
                    _lat = position.center!.latitude;
                    _lng = position.center!.longitude;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  // urlTemplate:
                  //     'http://{s}.google.com/vt?lyrs=m&x={x}&y={y}&z={z}',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: center,
                      // point: LatLng(_lat, _lng),
                      width: 80,
                      height: 80,
                      rotate: true,
                      builder: (BuildContext context) {
                        return Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        );
                      },
                    ),
                  ],
                ),
                // RichAttributionWidget(
                //   attributions: [
                //     TextSourceAttribution('OpenStreetMap contributors',
                //         onTap: () {
                //       // launchUrl(Uri.parse('https://openstreetmap.org/copyright');
                //     }),
                //   ],
                // ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.only(
                  left: 16.0, top: 10.0, right: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe5e5e5),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Pilih Alamat',
                    style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              right: 20,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // getLocation();
                      checkAndGetLocation();
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFe5e5e5),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Icon(
                        Icons.my_location,
                        size: 20,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFe5e5e5),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _currentZoom += 1; // Zoom In
                              _mapController.move(
                                  _mapController.center, _currentZoom);
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            // decoration: BoxDecoration(
                            //   color: AppColors.white,
                            //   shape: BoxShape.circle,
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Color(0xFFe5e5e5),
                            //       blurRadius: 10,
                            //       offset: Offset(0, 0),
                            //       spreadRadius: 0.5,
                            //     ),
                            //   ],
                            // ),
                            child: Center(
                                child: Icon(
                              Icons.add,
                              size: 20,
                            )),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _currentZoom -= 1; // Zoom Out
                              _mapController.move(
                                  _mapController.center, _currentZoom);
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            // decoration: BoxDecoration(
                            //   color: AppColors.white,
                            //   shape: BoxShape.circle,
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Color(0xFFe5e5e5),
                            //       blurRadius: 10,
                            //       offset: Offset(0, 0),
                            //       spreadRadius: 0.5,
                            //     ),
                            //   ],
                            // ),
                            child: Center(
                                child: Icon(
                              Icons.remove,
                              size: 20,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
        child: InkWell(
          onTap: () {
            Map<String, dynamic> data = {
              'latitude': _lat,
              'longitude': _lng,
            };
            Navigator.pop(context, data);
          },
          child: Container(
            width: double.infinity,
            height: 40,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF4FC4CF),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
                child: Text(
              'Pilih Lokasi',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )),
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return SafeArea(
      child: Stack(children: [
        Container(
            color: Colors.white,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                flex: 3,
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
                    ),
                  ))
            ])),
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Image.asset(
            'assets/icons/logo_sawargi.png',
            width: 80,
            height: 80,
          ),
        ),
        Positioned(
          top: screenHeight * 0.2,
          left: 20,
          right: 20,
          child: Column(
            children: [
              Text(
                'SAWARGI',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
              Text(
                'KOTA BANDUNG',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
            top: screenHeight * 0.4,
            left: 10,
            right: 10,
            // bottom: 0,
            child: Image.asset(
              'assets/images/img_spk.png',
              width: 250,
              height: 250,
            )),
        Positioned(
          left: 20,
          right: 20,
          bottom: 50,
          child: Center(
            child: GestureDetector(
              onTap: () async {
                final data = await SharedPreferencesUtil.getData();
                if (data == null || data.isEmpty) {
                  // Navigator.push(
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              },
              child: Container(
                width: screenWidth,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4FC4CF),
                      Color(0xFF4FC4CF),
                      // Color(0xFF08203B)
                    ], // Ubah warna sesuai keinginan
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                    child: Text(
                  'GET STARTED',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
