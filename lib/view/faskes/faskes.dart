import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/faskes/faskes_cubit.dart';
import 'package:sistem_pendataan_kewilayahan/utils/app_colors.dart';
import 'package:sistem_pendataan_kewilayahan/utils/shared_preferance_utils.dart';
import 'package:sistem_pendataan_kewilayahan/view/login/login_page.dart';

class FaskesPage extends StatefulWidget {
  const FaskesPage({super.key});

  @override
  State<FaskesPage> createState() => _FaskesPageState();
}

class _FaskesPageState extends State<FaskesPage> {
  var name = "";
  var role = "";

  @override
  void initState() {
    super.initState();
    getUserData();
    getFaskes();
  }

  Future getUserData() async {
    final data = await SharedPreferencesUtil.getData();
    setState(() {
      name = data['data']['name'];
      role = data['data']['role'];
    });
    return data;
  }

  Future<void> getFaskes() async {
    final data = await SharedPreferencesUtil.getData();
    if (data != null || data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context
            .read<FaskesCubit>()
            .getFaskes(data['data']['token'], data['data']['user_id']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: const Color(0xFFa3e0e5),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/img_bginput.png',
                        ),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.bottomRight),
                    gradient: LinearGradient(
                      colors: [Color(0xFF4FC4CF), Color(0xFFa3e0e5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$name ',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12,
                                decoration: TextDecoration
                                    .none, // Menghilangkan underline

                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            child: InkWell(
                              onTap: () async {
                                await SharedPreferencesUtil.removeUser();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white),
                                child: const Center(
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: AppColors.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'DATA Faskes',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Informasi data daftar \nfasilitas kesehatan yang tersimpan',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: BlocConsumer<FaskesCubit, FaskesState>(
                      listener: (context, state) async {
                    // if (state is ExpiredToken) {
                    //   await SharedPreferencesUtil.removeUser();
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     // _dialogExpiredToken(context);
                    //   });
                    // }
                  }, builder: (context, state) {
                    if (state is FaskesSuccess) {
                      final data = state.data['data']['survey'];
                      return data != null
                          ? ListView.builder(
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: screenWidth,
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 16, right: 16, bottom: 8),
                                  padding: EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data[index]['nama_faskes']}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: AppColors.textColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_month,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    '${data[index]['jadwal_praktek']['nama']}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .bedroom_child_outlined,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    '${data[index]['jumlah_tempat_tidur']}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.home_work,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    'Milik ${data[index]['status_kepemilikan']['nama']}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    '${data[index]['no_telp']}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_pin,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    '${data[index]['jalan']} RT ${data[index]['rt']} RW ${data[index]['rw']}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    '${data[index]['tipe_faskes']['nama']}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 20,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '(${data[index]['status_akreditasi']['nama']})',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              /*Row(
                                                children: [
                                                  Text(
                                                    '${data[index]['jumlah_tempat_tidur']}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 26,
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .bedroom_child_outlined,
                                                    size: 32,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),*/
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            )
                          : Container(
                              child: ListView(
                                children: [
                                  Center(
                                    child: Text(
                                      'Belum ada data yang di input',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    }
                    return Container(
                      child: Center(
                        child: Text(
                          '',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
