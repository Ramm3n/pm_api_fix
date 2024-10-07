import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';

class PpksPage extends StatefulWidget {
  final List<Map<String, dynamic>>? dataPpks;
  const PpksPage({super.key, this.dataPpks});

  @override
  State<PpksPage> createState() => _PpksPageState();
}

class _PpksPageState extends State<PpksPage> {
  List<Map<String, dynamic>> checkboxValues = [
    {"id": "1", "nmJenis": "Anak Balita Terlantar", "isChecked": false},
    {"id": "2", "nmJenis": "Anak Terlantar", "isChecked": false},
    {
      "id": "3",
      "nmJenis": "Anak Yang Berhadapan Dengan Hukum",
      "isChecked": false
    },
    {"id": "4", "nmJenis": "Anak Jalanan", "isChecked": false},
    {
      "id": "5",
      "nmJenis": "Anak Dengan Kedisabilitasan (ADK)",
      "isChecked": false
    },
    {
      "id": "6",
      "nmJenis":
          "Anak Yang Menjadi Korban Tindak Kekerasan atau Diperlakukan Salah",
      "isChecked": false
    },
    {
      "id": "7",
      "nmJenis": "Anak yang Memerlukan Perlindungan Khusus",
      "isChecked": false
    },
    {"id": "8", "nmJenis": "Lanjut Usia Terlantar", "isChecked": false},
    {"id": "9", "nmJenis": "Penyandang Disabilitas", "isChecked": false},
    {"id": "10", "nmJenis": "Tuna Susila", "isChecked": false},
    {"id": "11", "nmJenis": "Gelandangan", "isChecked": false},
    {"id": "12", "nmJenis": "Pengemis", "isChecked": false},
    {"id": "13", "nmJenis": "Pemulung", "isChecked": false},
    {"id": "14", "nmJenis": "Kelompok Minoritas", "isChecked": false},
    {
      "id": "15",
      "nmJenis": "Bekas Warga Binaan Lembaga Pemasyarakatan (BWBLP)",
      "isChecked": false
    },
    {"id": "16", "nmJenis": "Orang dengan HIV/AIDS (ODHA)", "isChecked": false},
    {"id": "17", "nmJenis": "Korban Penyalahgunaan NAPZA", "isChecked": false},
    {"id": "18", "nmJenis": "Korban Trafficking", "isChecked": false},
    {"id": "19", "nmJenis": "Korban Tindak Kekerasan", "isChecked": false},
    {
      "id": "20",
      "nmJenis": "Pekerja Migran Bermasalah Sosial (PMBS)",
      "isChecked": false
    },
    {"id": "21", "nmJenis": "Korban Bencana Alam", "isChecked": false},
    {"id": "22", "nmJenis": "Korban Bencana Sosial", "isChecked": false},
    {
      "id": "23",
      "nmJenis": "Perempuan Rawan Sosial Ekonomi",
      "isChecked": false
    },
    {"id": "24", "nmJenis": "Fakir Miskin", "isChecked": false},
    {
      "id": "25",
      "nmJenis": "Keluarga Bermasalah Sosial Psikologis",
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
    // Cek apakah ID item di checkboxValues ada di dataPsks
    for (var item in checkboxValues) {
      if (widget.dataPpks!.isNotEmpty ||
          widget.dataPpks != null ||
          widget.dataPpks != []) {
        if (widget.dataPpks!.any((data) => data['id'] == item['id'])) {
          //   // Jika ada kecocokan, atur isChecked menjadi true
          item['isChecked'] = true;
          // print('teesting ${widget.dataPsks}');
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
                    'DATA PPKS',
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
                      for (var item in checkboxValues)
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: item["isChecked"],
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                onChanged: (value) {
                                  setState(() {
                                    item["isChecked"] = value;
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  item["nmJenis"],
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF7E7E7E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[2],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[2] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Text(
                      //         'Anak Terlantar',
                      //         style: TextStyle(
                      //             color: Color(0xFF7E7E7E),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[3],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[3] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       const Text(
                      //         'Anak Yang Berhadapan Dengan Hukum',
                      //         style: TextStyle(
                      //             color: Color(0xFF7E7E7E),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[4],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[4] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       const Text(
                      //         'Anak Jalanan',
                      //         style: TextStyle(
                      //             color: Color(0xFF7E7E7E),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[5],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[5] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       const Text(
                      //         'Anak Dengan Kedisabilitasan (ADK)',
                      //         style: TextStyle(
                      //             color: Color(0xFF7E7E7E),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[6],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[6] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Anak Yang Menjadi Korban Tindak Kekerasan atau Diperlakukan Salah',
                      //           maxLines: 2,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[7],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[7] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Anak yang Memerlukan Perlindungan Khusus',
                      //           maxLines: 2,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[8],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[8] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Lanjut Usia Terlantar',
                      //           maxLines: 2,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[9],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[9] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Penyandang Disabilitas',
                      //           maxLines: 2,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[10],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[10] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Tuna Susila',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[11],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[11] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Gelandangan',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[12],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[12] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Pengemis',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[13],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[13] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Pemulung',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[14],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[14] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Kelompok Minoritas',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[15],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[15] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Bekas Warga Binaan Lembaga Pemasyarakatan (BWBLP)',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[16],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[16] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Orang dengan HIV/AIDS (ODHA)',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[17],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[17] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Korban Penyalahgunaan NAPZA',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[18],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[18] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Korban Trafficking',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[19],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[19] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Korban Tindak Kekerasan',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[20],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[20] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Pekerja Migran Bermasalah Sosial (PMBS)',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[21],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[21] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Korban Bencana Alam',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[22],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[22] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Korban Bencana Sosial',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[23],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[23] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Perempuan Rawan Sosial Ekonomi',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[24],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[24] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Fakir Miskin',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[25],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[25] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Keluarga Bermasalah Sosial Psikologis',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.0),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         value: isChecked[26],
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             isChecked[26] = value ?? false;
                      //           });
                      //         },
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           'Komunitas Adat Terpencil',
                      //           maxLines: 3,
                      //           style: TextStyle(
                      //               color: Color(0xFF7E7E7E),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
