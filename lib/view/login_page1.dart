import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_pendataan_kewilayahan/view/home/home_page.dart';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    bool isChecked = false;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0D3B71),
                      Color(0xFF08203B)
                    ], // Ubah warna sesuai keinginan
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                // child: Center(
                //   child: Text(
                //     'Kontainer 2',
                //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                //   ),
                // ),
              ),
            )
          ],
        ),
        Positioned(
            top: screenHeight * 0.13,
            left: 20,
            right: 20,
            child: Image.asset(
              'assets/icons/logo_spk.png',
              width: 80,
              height: 80,
            )),
        Positioned(
          top: screenHeight * 0.3,
          left: 20,
          right: 20,
          child: Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                // color: const Color(0xFFFDFDFD),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/icons/ic_username.png',
                                width: 10, height: 10),
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
                      SizedBox(height: 20),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/icons/ic_password.png',
                                width: 10, height: 10),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text('Remember Me')
                            ],
                          ),
                          Text('Forgot Password?')
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // const InputKependudukanPage()
                                    const HomePage()),
                          );
                        },
                        child: Container(
                          width: screenWidth,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0D3B71),
                                Color(0xFF08203B)
                              ], // Ubah warna sesuai keinginan
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: const Center(
                              child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: Text(
                          'Aplikasi Pendataan Kota Bandung',
                          style: TextStyle(
                              color: Color(0xFFB5B3B3),
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Text(
                        '© 2023 All Rights Reserved',
                        style: TextStyle(
                            color: Color(0xFFB5B3B3),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Pemerintah Kota Bandung',
                        style: TextStyle(
                            color: Color(0xFFB5B3B3),
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
