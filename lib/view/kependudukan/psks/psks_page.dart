import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/kependudukan_cubit.dart';

class PsksPage extends StatefulWidget {
  final List<Map<String, dynamic>>? dataPsks;
  const PsksPage({super.key, this.dataPsks});

  @override
  State<PsksPage> createState() => _PsksPageState();
}

class _PsksPageState extends State<PsksPage> {
  List<Map<String, dynamic>> checkboxValues = [
    {"id": "1", "nmJenis": "Pekerja Sosial Profesional", "isChecked": false},
    {
      "id": "2",
      "nmJenis": "Pekerja Sosial Masyarakat (PSM)",
      "isChecked": false
    },
    {"id": "3", "nmJenis": "Taruna Siaga Bencana (TAGANA)", "isChecked": false},
    {
      "id": "4",
      "nmJenis": "Lembaga Kesejahteraan Sosial (LKS)",
      "isChecked": false
    },
    {"id": "5", "nmJenis": "Karang Taruna", "isChecked": false},
    {
      "id": "6",
      "nmJenis": "Lembaga Konsultasi Kesejahteraan Keluarga (LK3)",
      "isChecked": false
    },
    {"id": "7", "nmJenis": "Keluarga Pioneer", "isChecked": false},
    {
      "id": "8",
      "nmJenis": "Wanita Pemimpin Kesejahteraan Sosial",
      "isChecked": false
    },
    {"id": "9", "nmJenis": "Dunia Usaha", "isChecked": false},
    {
      "id": "10",
      "nmJenis":
          "Wahana Kesejahteraan Sosial Keluarga Berbasis Masyarakat (WKSBM)",
      "isChecked": false
    },
    {"id": "11", "nmJenis": "Penyuluh Sosial", "isChecked": false},
    {
      "id": "12",
      "nmJenis": "Tenaga Kesejahteraan Sosial Kecamatan (TKSK)",
      "isChecked": false
    }
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
      if (widget.dataPsks!.isNotEmpty ||
          widget.dataPsks != null ||
          widget.dataPsks != []) {
        if (widget.dataPsks!.any((data) => data['id'] == item['id'])) {
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
                    'DATA PSKS',
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
                                  '${item["nmJenis"]}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                      //         'Pekerja Sosial Masyarakat (PSM)',
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
                      //         'Taruna Siaga Bencana (TAGANA)',
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
                      //         'Lembaga Kesejahteraan Sosial (LKS)',
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
                      //         'Karang Taruna',
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
                      //           'Lembaga Konsultasi Kesejahteraan Keluarga (LK3)',
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
                      //           'Keluarga Pioneer',
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
                      //           'Wanita Pemimpin Kesejahteraan Sosial',
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
                      //           'Dunia Usaha',
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
                      //           'Wahana Kesejahteraan Sosial Keluarga Berbasis Masyarakat (WKSBM)',
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
                      //           'Penyuluh Sosial',
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
                      //           'Tenaga Kesejahteraan Sosial Kecamatan (TKSK)',
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
                          // String dataToSend = dataController.text;
                          // checkboxValues.
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
