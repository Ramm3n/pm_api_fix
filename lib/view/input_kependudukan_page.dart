import 'package:flutter/material.dart';
import 'package:sistem_pendataan_kewilayahan/view/kependudukan/anggota/input_anggota_page.dart';

class InputKependudukanPage extends StatefulWidget {
  const InputKependudukanPage({super.key});

  @override
  State<InputKependudukanPage> createState() => _InputKependudukanPageState();
}

class _InputKependudukanPageState extends State<InputKependudukanPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Card(
                elevation: 4,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'INPUT DATA\nKEPENDUDUKAN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF0A0A0A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lobortis, eros quis consequat efficitur, nunc ante pretium est, eu condimentum tortor ante ac nibh.',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFF7E7E7E),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Nomor Kartu Keluarga',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Nomor KK",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45))),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Nama Kepala Keluarga',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Nama KK",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45))),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Alamat Keluarga',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Alamat",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 40.0,
                                horizontal:
                                    12.0), // Mengatur tinggi dengan contentPadding
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'RT',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF0D3B71),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 100,
                                    child: TextField(
                                      // controller: _textEditingController,
                                      decoration: InputDecoration(
                                        hintText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(45))),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(12.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'RW',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF0D3B71),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 100,
                                    child: TextField(
                                      // controller: _textEditingController,
                                      decoration: InputDecoration(
                                        hintText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(45))),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(12.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Kelurahan',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Kelurahan",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45))),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Kecamatan',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Kecamatan",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45))),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Kabupaten/Kota',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Kabupaten/Kota",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45))),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Provinsi',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Provinsi",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45))),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Lokasi Objek',
                            style: TextStyle(
                                color: Color(0xFF0D3B71),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Input Lokasi Objek",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45))),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputAnggotaPage()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Tambah Anggota Keluarga',
                                  style: TextStyle(
                                      color: Color(0xFF0D3B71),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(left: 6.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF0D3B71),
                                          Color(0xFF08203B)
                                        ], // Ubah warna sesuai keinginan
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white, // Warna ikon
                                      size: 20.0, // Ukuran ikon
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InputKependudukanPage()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
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
    // return Container(
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [
    //         Color(0xFF0D3B71),
    //         Color(0xFF08203B)
    //       ], // Ubah warna sesuai keinginan
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //     ),
    //   ),
    //   child: SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: Card(
    //         elevation: 4,
    //         shape: const RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(10))),
    //         child: SingleChildScrollView(
    //           child: Container(
    //             margin: const EdgeInsets.all(20),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: const [
    //                     Text(
    //                       'INPUT DATA\nKEPENDUDUKAN',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(
    //                           color: Color(0xFF0A0A0A),
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.w900),
    //                     ),
    //                   ],
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(20.0),
    //                   child: Text(
    //                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lobortis, eros quis consequat efficitur, nunc ante pretium est, eu condimentum tortor ante ac nibh.',
    //                     textAlign: TextAlign.center,
    //                     maxLines: 2,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: TextStyle(
    //                         color: Color(0xFF7E7E7E),
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Nomor Kartu Keluarga',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Nomor KK",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(45))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.all(12.0),
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Nama Kepala Keluarga',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Nama KK",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(45))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.all(12.0),
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Alamat Keluarga',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Alamat",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(20))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.symmetric(
    //                         vertical: 40.0,
    //                         horizontal:
    //                             12.0), // Mengatur tinggi dengan contentPadding
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                       left: 8.0, right: 8.0, top: 10.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text(
    //                             'RT',
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                                 color: Color(0xFF0D3B71),
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.w700),
    //                           ),
    //                           SizedBox(width: 10),
    //                           Container(
    //                             width: 100,
    //                             child: TextField(
    //                               // controller: _textEditingController,
    //                               decoration: InputDecoration(
    //                                 hintText: "",
    //                                 border: OutlineInputBorder(
    //                                     borderRadius: BorderRadius.all(
    //                                         Radius.circular(45))),
    //                                 isDense: true,
    //                                 contentPadding: EdgeInsets.all(12.0),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: [
    //                           Text(
    //                             'RW',
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                                 color: Color(0xFF0D3B71),
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.w700),
    //                           ),
    //                           SizedBox(width: 10),
    //                           Container(
    //                             width: 100,
    //                             child: TextField(
    //                               // controller: _textEditingController,
    //                               decoration: InputDecoration(
    //                                 hintText: "",
    //                                 border: OutlineInputBorder(
    //                                     borderRadius: BorderRadius.all(
    //                                         Radius.circular(45))),
    //                                 isDense: true,
    //                                 contentPadding: EdgeInsets.all(12.0),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Kelurahan',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Kelurahan",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(45))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.all(12.0),
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Kecamatan',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Kecamatan",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(45))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.all(12.0),
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Kabupaten/Kota',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Kabupaten/Kota",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(45))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.all(12.0),
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Provinsi',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Provinsi",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(45))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.all(12.0),
    //                   ),
    //                 ),
    //                 const Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Text(
    //                     'Lokasi Objek',
    //                     style: TextStyle(
    //                         color: Color(0xFF0D3B71),
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ),
    //                 const TextField(
    //                   // controller: _textEditingController,
    //                   decoration: InputDecoration(
    //                     hintText: "Input Lokasi Objek",
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(45))),
    //                     isDense: true,
    //                     contentPadding: EdgeInsets.all(12.0),
    //                   ),
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => const InputAnggotaPage()),
    //                     );
    //                   },
    //                   child: Padding(
    //                     padding: EdgeInsets.all(10.0),
    //                     child: Row(
    //                       children: [
    //                         const Text(
    //                           'Tambah Anggota Keluarga',
    //                           style: TextStyle(
    //                               color: Color(0xFF0D3B71),
    //                               fontSize: 14,
    //                               fontWeight: FontWeight.w700),
    //                         ),
    //                         Center(
    //                           child: Container(
    //                             width: 20,
    //                             height: 20,
    //                             margin: EdgeInsets.only(left: 6.0),
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(5.0),
    //                               gradient: const LinearGradient(
    //                                 colors: [
    //                                   Color(0xFF0D3B71),
    //                                   Color(0xFF08203B)
    //                                 ], // Ubah warna sesuai keinginan
    //                                 begin: Alignment.topCenter,
    //                                 end: Alignment.bottomCenter,
    //                               ),
    //                               shape: BoxShape.rectangle,
    //                             ),
    //                             child: const Icon(
    //                               Icons.add,
    //                               color: Colors.white, // Warna ikon
    //                               size: 20.0, // Ukuran ikon
    //                             ),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 10),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) =>
    //                               const InputKependudukanPage()),
    //                     );
    //                   },
    //                   child: Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     height: 40,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(45.0),
    //                       gradient: const LinearGradient(
    //                         colors: [
    //                           Color(0xFF0D3B71),
    //                           Color(0xFF08203B)
    //                         ], // Ubah warna sesuai keinginan
    //                         begin: Alignment.topCenter,
    //                         end: Alignment.bottomCenter,
    //                       ),
    //                     ),
    //                     child: const Center(
    //                         child: Text(
    //                       'SUBMIT',
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.bold),
    //                     )),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
