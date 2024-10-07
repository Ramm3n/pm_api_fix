import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/view/lokasi/input_lokasi_page.dart';

class PohonPage extends StatefulWidget {
  const PohonPage({super.key});

  @override
  State<PohonPage> createState() => _PohonPageState();
}

class _PohonPageState extends State<PohonPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
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
              top: screenHeight * 0.1,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATA POHON',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pastikan data yang dimasukkan\ntelah sesuai dan benar ',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
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
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Teks di tengah
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputLokasiPage()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Lokasi Objek',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputLokasiPage()),
                            );
                          },
                          child: TextField(
                            // controller: _textEditingController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Masukkan Lokasi Objek",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB7B7B7)),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              isDense: true,
                              contentPadding: EdgeInsets.all(12.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Nama Pohon',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Nama Pohon",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFB7B7B7)),
                            filled: true,
                            fillColor: const Color(0xFFF6F6F6),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(12.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Tanggal ditanam',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Tanggal ditanam",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFB7B7B7)),
                            filled: true,
                            fillColor: const Color(0xFFF6F6F6),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(12.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Jenis Pohon',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Jenis Pohon",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFB7B7B7)),
                            filled: true,
                            fillColor: const Color(0xFFF6F6F6),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(12.0),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           const InputKependudukanPage()),
                            // );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
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
                            child: const Center(
                                child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
