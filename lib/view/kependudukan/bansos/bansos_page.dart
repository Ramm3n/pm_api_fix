import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';

class BansosPage extends StatefulWidget {
  final List<Map<String, dynamic>>? dataBansos;
  const BansosPage({super.key, this.dataBansos});

  @override
  State<BansosPage> createState() => _BansosPageState();
}

class _BansosPageState extends State<BansosPage> {
  List<Map<String, dynamic>> checkboxValues = [
    {
      "id": "1",
      "type": "Program Nasional (APBN)",
      "nmJenis": "KUBE",
      "isChecked": false
    },
    {
      "id": "2",
      "type": "Program Nasional (APBN)",
      "nmJenis": "BPNT",
      "isChecked": false
    },
    {
      "id": "3",
      "type": "Program Nasional (APBN)",
      "nmJenis": "PKH",
      "isChecked": false
    },
    {
      "id": "4",
      "type": "Program Nasional (APBN)",
      "nmJenis": "KIS",
      "isChecked": false
    },
    {
      "id": "5",
      "type": "Program Nasional (APBN)",
      "nmJenis": "BSPS",
      "isChecked": false
    },
    {
      "id": "6",
      "type": "Program Nasional (APBN)",
      "nmJenis": "PISEW",
      "isChecked": false
    },
    {
      "id": "7",
      "type": "Program Nasional (APBN)",
      "nmJenis": "KIP",
      "isChecked": false
    },
    {
      "id": "8",
      "type": "Program Nasional (APBN)",
      "nmJenis": "KKS",
      "isChecked": false
    },
    {
      "id": "9",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "Layanan Pemakanan Gratis",
      "isChecked": false
    },
    {
      "id": "10",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "RASTRA",
      "isChecked": false
    },
    {
      "id": "11",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "PBI-Kota Bandung",
      "isChecked": false
    },
    {
      "id": "12",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "UMKM",
      "isChecked": false
    },
    {
      "id": "13",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "Transfortasi Gratis",
      "isChecked": false
    },
    {
      "id": "14",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "PBB Gratis",
      "isChecked": false
    },
    {
      "id": "15",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "Pajak Kendaraan Gratis",
      "isChecked": false
    },
    {
      "id": "16",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "ATM Beras",
      "isChecked": false
    },
    {
      "id": "17",
      "type": "Program Kota Bandung (APBD)",
      "nmJenis": "Rutilahu",
      "isChecked": false
    },
    {"id": "18", "type": "Program CSR", "nmJenis": "PLN", "isChecked": false},
    {
      "id": "19",
      "type": "Program CSR",
      "nmJenis": "Pertamina",
      "isChecked": false
    },
    {"id": "20", "type": "Program CSR", "nmJenis": "BUMN", "isChecked": false},
    {"id": "21", "type": "Program CSR", "nmJenis": "BUMD", "isChecked": false},
    {
      "id": "22",
      "type": "Program CSR",
      "nmJenis": "Baznas",
      "isChecked": false
    },
  ];
  List<bool> isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var item in checkboxValues) {
      if (widget.dataBansos!.isNotEmpty ||
          widget.dataBansos != null ||
          widget.dataBansos != []) {
        if (widget.dataBansos!
            .any((data) => data['id'].toString() == item['id'])) {
          //   // Jika ada kecocokan, atur isChecked menjadi true
          item['isChecked'] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final kependudukanCubit = context.read<KependudukanCubit>();
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
                    'Penerima Bantuan Sosial',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Pastikan data yang dipilih telah\nsesuai dan benar',
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
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Teks di tengah
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Program APBN',
                        style: TextStyle(
                            color: Color(0xFF4FC4CF),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF4FC4CF),
                              Color(0xFFa3e0e5),
                              Color(0xFFFFFFFF),
                            ], // Ubah warna sesuai keinginan
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: checkboxValues.map((item) {
                            if (item['type'] == "Program Nasional (APBN)") {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: item['isChecked'],
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    onChanged: (value) {
                                      setState(() {
                                        item['isChecked'] = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    item['nmJenis'],
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFF7E7E7E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox
                                  .shrink(); // Misalnya, kita akan menampilkan widget kosong.
                            }
                          }).toList()),
                      SizedBox(height: 10),
                      Text(
                        'Program Kota Bandung (APBD)',
                        style: TextStyle(
                            color: Color(0xFF4FC4CF),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF4FC4CF),
                              Color(0xFFa3e0e5),
                              Color(0xFFFFFFFF),
                            ], // Ubah warna sesuai keinginan
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: checkboxValues.map((item) {
                            if (item['type'] == "Program Kota Bandung (APBD)") {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: item['isChecked'],
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    onChanged: (value) {
                                      setState(() {
                                        item['isChecked'] = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    item['nmJenis'],
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFF7E7E7E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox
                                  .shrink(); // Misalnya, kita akan menampilkan widget kosong.
                            }
                          }).toList()),
                      SizedBox(height: 10),
                      Text(
                        'Program CSR',
                        style: TextStyle(
                            color: Color(0xFF4FC4CF),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF4FC4CF),
                              Color(0xFFa3e0e5),
                              Color(0xFFFFFFFF),
                            ], // Ubah warna sesuai keinginan
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: checkboxValues.map((item) {
                            if (item['type'] == "Program CSR") {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: item['isChecked'],
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    onChanged: (value) {
                                      setState(() {
                                        item['isChecked'] = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    item['nmJenis'],
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFF7E7E7E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox
                                  .shrink(); // Misalnya, kita akan menampilkan widget kosong.
                            }
                          }).toList()),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          List<Map<String, dynamic>> checkedData =
                              checkboxValues
                                  .where((item) => item["isChecked"] == true)
                                  .toList();
                          Navigator.pop(context, checkedData);
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
          ],
        ),
      ),
    );
  }
}
