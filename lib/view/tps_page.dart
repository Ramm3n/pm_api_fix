import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:multiselect/multiselect.dart';
import 'package:sistem_pendataan_kewilayahan/view/lokasi/input_lokasi_page.dart';

class Fasilitas {
  final int id;
  final String name;

  Fasilitas({
    required this.id,
    required this.name,
  });
}

class TpsPage extends StatefulWidget {
  const TpsPage({super.key});

  @override
  State<TpsPage> createState() => _TpsPageState();
}

class _TpsPageState extends State<TpsPage> {
  static List<Fasilitas> _fasilitas = [
    Fasilitas(id: 1, name: '3R'),
    Fasilitas(id: 2, name: 'TPST'),
    Fasilitas(id: 3, name: 'LANDASAN'),
    Fasilitas(id: 4, name: 'DINDING'),
    Fasilitas(id: 5, name: 'ATAP'),
    Fasilitas(id: 6, name: 'KONTAINER'),
  ];

  final _items = _fasilitas
      .map((fasilitas) => MultiSelectItem<Fasilitas>(fasilitas, fasilitas.name))
      .toList();

  List<Fasilitas> selectedFasilitas = [];
  List<String> pemilik = ['UPTD', 'PEMKOT', 'FASUM', 'PASAR'];
  List<String> selectedPemilik = [];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(children: [
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
                  'DATA TEMPAT PEMBUANGAN SAMPAH SEMENTARA',
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
                          'Wilayah',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Wilayah",
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
                          'Fasilitas',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      MultiSelectBottomSheetField(
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        // backgroundColor: const Color(0xFFF6F6F6),
                        buttonText: Text(
                          "Pilih Fasilitas",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFB7B7B7)),
                        ),
                        buttonIcon: Icon(Icons.arrow_drop_down),
                        title: Text(
                          "Fasilitas",
                          style: GoogleFonts.poppins(
                              color: const Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            border: Border.fromBorderSide(BorderSide.none),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        items: _items,
                        itemsTextStyle: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        selectedItemsTextStyle: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        onConfirm: (values) {
                          // selectedFasilitas = values;
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          textStyle: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          onTap: (value) {
                            setState(() {
                              selectedFasilitas.remove(value);
                            });
                          },
                        ),
                      ),
                      // DropDownMultiSelect(
                      //   options: fasilitas,
                      //   selectedValues: selectedFasilitas,
                      //   onChanged: (value) {
                      //     // print('selected $value');
                      //     setState(() {
                      //       selectedFasilitas = value;
                      //     });
                      //     // print('you have selected $selectedFruits fruits.');
                      //   },
                      //   whenEmpty: 'Pilih Fasilitas',
                      //   decoration: InputDecoration(
                      //     // hintText: "Masukkan Luas Lahan",
                      //     hintStyle: GoogleFonts.poppins(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w500,
                      //         color: const Color(0xFFB7B7B7)),
                      //     filled: true,
                      //     fillColor: const Color(0xFFF6F6F6),
                      //     border: const OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(10))),
                      //     isDense: true,
                      //     contentPadding: const EdgeInsets.all(12.0),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Luas Lahan',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Luas Lahan",
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
                          'Luas Bangunan',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Luas Bangunan",
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
                          'Kepemilikan Lahan',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      // DropDownMultiSelect(
                      //   options: pemilik,
                      //   selectedValues: selectedPemilik,
                      //   onChanged: (value) {
                      //     // print('selected $value');
                      //     setState(() {
                      //       selectedPemilik = value;
                      //     });
                      //   },
                      //   whenEmpty: 'Pilih Kepemilikan',
                      //   decoration: InputDecoration(
                      //     // hintText: "Masukkan Luas Lahan",
                      //     hintStyle: GoogleFonts.poppins(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w500,
                      //         color: const Color(0xFFB7B7B7)),
                      //     filled: true,
                      //     fillColor: const Color(0xFFF6F6F6),
                      //     border: const OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(10))),
                      //     isDense: true,
                      //     contentPadding: const EdgeInsets.all(12.0),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Sampah yang Masuk',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Sampah yang Masuk",
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
                          'Sampah Diangkut ke TPA',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Sampah diangkut ke TPA",
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
                          'Jadwal Ritasi',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Ritasi",
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
                          'No Kendaraan',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan No Kendaraan",
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
                          'Jenis Kendaraan',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Jenis Kendaraan",
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
                          'Jadwal Pengangkutan',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextField(
                        // controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Jadwal Pengangkutan",
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
        ]),
      ),
    );
  }
}
