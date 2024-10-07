import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/auth/auth_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAlertDialogShown = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    bool isChecked = false;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF4FC4CF),
      statusBarIconBrightness: Brightness.light, // For Android
      statusBarBrightness: Brightness.light, // For iOS
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.45,
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
            Positioned(
                top: screenHeight * 0.24,
                right: 10,
                // left: 20,
                // bottom: 0,
                child: Image.asset(
                  'assets/images/img_verify.png',
                  width: 180,
                  height: 180,
                )),
            Positioned(
              top: 0,
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
                              decoration: TextDecoration
                                  .none, // Menghilangkan underline

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
                              decoration: TextDecoration
                                  .none, // Menghilangkan underline

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
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOG IN AKUN',
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: Color(0xFFFFFFFF),
                        fontSize: 22,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'untuk melanjutkan\npendataan\nkependudukan\nKota Bandung',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  // if (state is AuthLoading) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                  if (state is AuthFailed && !isAlertDialogShown) {
                    // setState(() {
                    isAlertDialogShown = true;
                    // });
                    // if (isAlertDialogShown) {
                    // if (FocusScope.of(context).hasFocus) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _dialogAuthResponse(context);
                    });
                    // }
                    // }
                  }
                  if (state is AuthSuccess) {
                    await SharedPreferencesUtil.saveData(state.data);
                    print('${state.data}');
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    });
                  }
                  // return Container();
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              ),
            ),
            Positioned(
              top: screenHeight * 0.52,
              left: 20,
              right: 20,
              child: Container(
                width: screenWidth,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // height: 40,
                        width: screenWidth,
                        // color: const Color(0xFFFDFDFD),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFF6F6F6)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(children: [
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: "Username",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFB7B7B7),
                                ),
                                border: InputBorder.none,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 24,
                                    color: Color(0xFFB7B7B7),
                                  ),
                                ),
                                isDense:
                                    true, // Mengurangi padding di dalam TextField
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              onChanged: (text) {
                                // Aksi yang ingin Anda lakukan ketika teks berubah
                                // print('Teks berubah: $text');
                              },
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        // height: 40,
                        width: screenWidth,
                        // color: const Color(0xFFFDFDFD),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFF6F6F6)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(children: [
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFB7B7B7),
                                ),
                                border: InputBorder.none,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: Color(0xFFB7B7B7),
                                  ),
                                ),
                                isDense:
                                    true, // Mengurangi padding di dalam TextField
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              onChanged: (text) {
                                // Aksi yang ingin Anda lakukan ketika teks berubah
                                // print('Teks berubah: $text');
                              },
                            ),
                          ]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                        width: 1.5, color: Color(0xFFB7B7B7))),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                'Remember Me',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFB7B7B7)),
                              )
                            ],
                          ),
                          Text(
                            'Forgot Password?',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4FC4CF)),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           // const InputKependudukanPage()
                          //           const HomePage()),
                          // );
                          authCubit.doLogin(_usernameController.text.trim(),
                              _passwordController.text.trim());
                        },
                        child: Container(
                          width: screenWidth,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4FC4CF),
                                Color(0xFF4FC4CF)
                              ], // Ubah warna sesuai keinginan
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'LOG IN',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: Text(
                          'Aplikasi Pendataan Kota Bandung',
                          style: GoogleFonts.poppins(
                              color: Color(0xFFB5B3B3),
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Text(
                        '© 2023 All Rights Reserved',
                        style: GoogleFonts.poppins(
                            color: Color(0xFFB5B3B3),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Pemerintah Kota Bandung',
                        style: GoogleFonts.poppins(
                            color: Color(0xFFB5B3B3),
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dialogAuthResponse(BuildContext context) {
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
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.amber,
                  size: 80,
                ),
                Text(
                  'Login Gagal',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Periksa kembali username dan password anda',
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
                Navigator.of(context).pop(); // Tutup dialog
                // setState(() {
                // });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
