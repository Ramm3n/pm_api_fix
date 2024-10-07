import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/view/lokasi/input_lokasi_page.dart';

class InputOlahragaPage extends StatefulWidget {
  const InputOlahragaPage({super.key});

  @override
  State<InputOlahragaPage> createState() => _InputOlahragaPageState();
}

class _InputOlahragaPageState extends State<InputOlahragaPage> {
  String selectedValue = "";
  List<Map<String, dynamic>> options = [
    {'value': '1', 'nama': 'Futsal'},
    {'value': '2', 'nama': 'Basket'},
    {'value': '3', 'nama': 'Volly'},
    {'value': '4', 'nama': 'Kolam Renang'},
    {'value': '5', 'nama': 'Tenis'},
  ];
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
                    'DATA FASILITAS OLAHRAGA',
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Nama Fasilitas',
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
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 4.0, left: 4.0, right: 10.0),
                          child: Text(
                            'Jenis Olahraga',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0), // Radius
                          ),
                          child: DropdownButtonFormField<String>(
                            // DropdownButtonFormField<Map<String, dynamic>>(
                            value: selectedValue,
                            items: [
                              DropdownMenuItem<String>(
                                value: "",
                                child: Text(
                                  "Pilih Jenis Olahraga",
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
                              // if (_isSubmitted) {
                              if (value == null || value.isEmpty) {
                                return 'Harus diisi';
                              }
                              // }
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              contentPadding: const EdgeInsets.all(12.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Alamat',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Alamat",
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
                            'Luas',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Luas",
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Kapasitas',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Masukkan Kapasitas",
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
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Foto',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF2E2E2E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.file_upload_outlined)
                                ],
                              ),
                              Container(
                                width: screenWidth,
                                height: 60,
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.insert_drive_file_outlined,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Foto lapangan kanan.png",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "200 KB",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Icon(Icons.close)
                                  ],
                                ),
                              ),
                            ],
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
