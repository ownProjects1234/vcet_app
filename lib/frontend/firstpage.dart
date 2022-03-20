import 'dart:io';
import 'package:collection/collection.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcet/backend/displayfiles.dart';
import 'package:vcet/chat/pages/home_page.dart';
import 'package:vcet/colorClass.dart';

import 'package:vcet/frontend/drawers.dart';

import 'package:vcet/frontend/menuwidget.dart';

import 'package:vcet/frontend/Appbar.dart';
import 'package:vcet/frontend/notification.dart';
import 'package:vcet/frontend/quiz.dart';
import 'package:vcet/frontend/upload.dart';

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  _firstpageState createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  int index = 2;
  // ignore: non_constant_identifier_names

  Function same = const ListEquality().equals;
  String dept = '';

  var value = 120.0;

  List<String> ece1sem = [
    "Communicative English",
    "Engineering Mathematics - I",
    "Engineering Physics",
    "Engineering Chemistry",
    "Engineering Grapics",
    "Pspp"
  ];
  String ece1 = "Communicative English";
  // var newvalueselected = "";
  List<String> ece2sem = [
    "Technical English",
    "Engineering Mathematics - II",
    "Physics for Electronics Engineering",
    "BEIE",
    "Circuit Analysis",
    "Electronic Devices"
  ];

  List<String> ece3sem = [
    "LAPDE",
    "FDSC",
    "Electronic Circuits - I",
    "Signals and Systems",
    "Digital Electronics",
    "Control System Engineering"
  ];
  List<String> ece4sem = [
    "Probabiilty and Random Processes",
    "Electronic Circuits II",
    "Communication Theory",
    "Electromagnetic Fields",
    "Linear Integrated Circuits",
    "ESE"
  ];
  List<String> ece5sem = [
    "Digital Communication",
    "DTSP",
    "CAO",
    "Communication Network",
    "Professional Elective I",
    "Open Elective I"
  ];
  List<String> ece6sem = [
    "Microprocessor & Microcontrollers",
    "VLSI Design",
    "Wireless Communication",
    "Principles of Management",
    "TLRS",
    "Professional Elective II"
  ];
  List<String> ece7sem = [
    "AME",
    "Optical Communication",
    "ERTS",
    "Ad hoc & WSN",
    "Professional Elective III",
    "Open Elective II"
  ];
  List<String> ece8sem = [
    "Professional Elective IV",
    "Professional Elective V"
  ];
  List<String> cse1sem = [
    "Communicative English",
    "Engineering Mathematics1",
    "Engineering Physics",
    "Engineering Chemistry",
    "Engineering Grapics",
    "PSP"
  ];
  List<String> cse2sem = [
    "Technical English",
    "Physics for Information Science",
    "BEEME",
    "ESE",
    "Programming in C"
  ];
  List<String> cse3sem = [
    "Discrete Mathematics",
    "DPD",
    "Data Structure",
    "Object Oriented Programming",
    "Communication Engineering"
  ];
  List<String> cse4sem = [
    "PQT",
    "Computer Architecture",
    "Database MS",
    "Design & Analysis of Algorithms",
    "Operating Systems",
    "Software Engineering"
  ];
  List<String> cse5sem = [
    "Algebra & Number Theory",
    "Computer Networks",
    "Microprocessors and Microcontrollers",
    "Theory of Computation",
    "OOAD",
    "Open Elective I"
  ];
  List<String> cse6sem = [
    "Internet Programming",
    "AI",
    "Mobile Computing",
    "Computer Design",
    "Distributed Systems",
    "Professional Elective I"
  ];
  List<String> cse7sem = [
    "Principles of Management",
    "Cyptography and Network Security",
    "Cloud Computing",
    "Open Elective II",
    "Professional Elective II",
    "Professional Elective III"
  ];
  List<String> cse8sem = [
    "Professional Elective IV",
    "Professional Elective V"
  ];
  List<String> eee1sem = [
    "Communicative English",
    "Engineering Mathematics1",
    "Engineering Physics",
    "Engineering Chemistry",
    "Engineering Grapics",
    "PSP"
  ];
  List<String> eee2sem = [
    "Technical English",
    " Engineering Mathematics",
    "Physics For Electronics Engg",
    "BCME",
    "Circuit Theory",
    "ESE"
  ];
  List<String> eee3sem = [
    "TPDE ",
    "Digital Logic Circuits",
    " Electromagnetic Theory",
    "Electrical  Machines–I",
    "EDCPPE"
  ];
  List<String> eee4sem = [
    "Numerical Methods",
    " Electrical Machines–II",
    "Transmission & Distribution",
    "Measurements & Instrumentation",
    "LICA",
    " Control Systems"
  ];
  List<String> eee5sem = [
    "Power System Analysis",
    "Microprocessors & Microcontrollers",
    " Power Electronics",
    " Digital Signal Processing",
    " Object Oriented Programming",
    " OpenElective I"
  ];
  List<String> eee6sem = [
    "Solid State Drives",
    " Protection and Switchgear",
    " Embedded Systems",
    "Professional Elective  I",
    " Professional Elective  II"
  ];
  List<String> eee7sem = [
    "High Voltage Engineering",
    "PSOC",
    "RenewableEnergy Systems",
    " Open Elective  II",
    "Professional ElectiveIII",
    "Professional ElectiveIV"
  ];
  List<String> eee8sem = [
    "Professional Elective V",
    "Professional Elective VI"
  ];
  List<String> it1sem = [
    "Communicative English",
    "Engineering Mathematics1",
    "Engineering Physics",
    "Engineering Chemistry",
    "Engineering Grapics",
    "PSP"
  ];
  List<String> it2sem = [
    "Technical English",
    "Engineering Mathematics II",
    "Physics for Information Science",
    " BEEME",
    " Information Technology Essentials",
    "Programming in C"
  ];
  List<String> it3sem = [
    "Discrete Mathematics",
    "DPSD",
    "Data Structures",
    "Object Oriented Programming",
    "Analog & Digital Communication"
  ];
  List<String> it4sem = [
    "Probability and Statistics",
    "Computer Architecture",
    "Database Management Systems",
    "Design and Analysis of Algorithms",
    "Operating Systems",
    "ESE"
  ];
  List<String> it5sem = [
    "Algebra and Number Theory",
    "Computer Networks",
    "Microprocessors & Microcontrollers",
    "web Technology",
    "Software Engineering "
  ];
  List<String> it6sem = [
    "Computer Intelligence",
    "OOAD",
    "Mobile Communication",
    "Big Data Analytics",
    "CGM"
  ];
  List<String> it7sem = [
    "Principles of Management",
    "Cryptography and Network Security",
    "Cloud computing",
    "Open Elective II",
    "Professional Elective II",
    "Professional Elective III"
  ];
  List<String> it8sem = ["Professional Elective IV", "Professional Elective V"];
  List<String> civil1sem = [
    "Communicative English",
    "Engineering Mathematics1",
    "Engineering Physics",
    "Engineering Chemistry",
    "Engineering Grapics",
    "PSP"
  ];
  List<String> civil2sem = [
    "Technical English",
    "Engineering Mathematics II",
    "Physics for Civil ENgineering",
    "BEEE",
    "ESE",
    "Engineering Mechanics"
  ];
  List<String> civil3sem = [
    "TPDE",
    "Engineering Geology",
    "Construction Mateirals",
    "Strength of Materials I",
    "Fluid Mechanics",
    "Surveying"
  ];
  List<String> civil4sem = [
    "Numerical Methods",
    "CTP",
    "Strength of Materials II",
    "Applied Hydraullic Engineering",
    "Concrete Technology",
    "Soli Mechanics"
  ];
  List<String> civil5sem = [
    "DRCCE",
    "Foundation Engineering",
    "Structural Analysis I",
    "Water Supply Engineering",
    "Open Elective I",
    "Professional Elective I"
  ];
  List<String> civil6sem = [
    "DSSE",
    "Structural Analysis II",
    "Irrigation Engineering",
    "Wastewater Engineering",
    "Highway Engineering",
    "Professional Elective II"
  ];
  List<String> civil7sem = [
    "ECVE",
    "RADHE",
    "Structural Design and Drawing",
    "Professional Elective III",
    "Open Elective II"
  ];
  List<String> civil8sem = [
    "Professional Elective IV",
    "Professional Elective V"
  ];
  List<String> mech1sem = [
    "Communicative English",
    "Engineering Mathematics1",
    "Engineering Physics",
    "Engineering Chemistry",
    "Engineering Grapics",
    "PSP"
  ];
  List<String> mech2sem = [
    "Technical English",
    "Engineering Mathematics II",
    "Material Science",
    "BEEIE",
    "ESE",
    "Engineering Mechanics"
  ];
  List<String> mech3sem = [
    "TPDE",
    "Engineering Thermodynamics",
    "Fluid Mechanics and Machinery",
    "Manufacturing Technology I",
    "Electrical Drives and Controls"
  ];
  List<String> mech4sem = [
    "Statistics and Numerical Methods",
    "Kinematics of Machinery",
    "Manufacturing Technology II",
    "Engineering Metallurgy",
    "SMME",
    "Thermal Engineering I"
  ];
  List<String> mech5sem = [
    "Thermal Engineering II",
    "Design of Machine Elements",
    "Metrology and Measurements",
    "Dynamics of Machines",
    "Open Elective I"
  ];
  List<String> mech6sem = [
    "DTS",
    "CADM",
    "Head & Mass Transfer",
    "Finite Element Analysis",
    "Hydraulics and Pneumatics",
    "Professional Elective I"
  ];
  List<String> mech7sem = [
    "Power plant Engineering",
    "PPCE",
    "Mechatronics",
    "Open Elective II",
    "Professional Elective II",
    "Professional Elective III"
  ];
  List<String> mech8sem = [
    "Principles of Management",
    "Professional Elective IV"
  ];

  @override
  Widget build(BuildContext context) {
    Card buildCard(String pic, String name) {
      return Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        //  padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image(
              image: AssetImage('images/project/$pic.jpg'),
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        ),
      );
    }

    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        extendBody: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Colors.indigo.shade300,
                //Colors.purple,
                Colors.blue,
                Colors.cyan
                // Colors.blue.shade200,
                // Colors.indigoAccent
              ])),
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("images/project/pldEkV.jpg"),
          //         fit: BoxFit.fill)
          //     //m gradient: LinearGradient(
          //     //   colors: [Colors.pinkAccent, Colors.red, Colors.black]
          //     //     )
          //     ),
          // color: myColors.buttonColor,
          child: Column(
            children: [
              Container(
                height: size.height * 0.74,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.2 - 30,
                      decoration: BoxDecoration(
                          color: myColors.secondaryColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36))),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 8,
                      child: Container(
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 8, right: 8),
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 12,
                          crossAxisCount: 3,
                          children: <Widget>[
                            GestureDetector(
                                child: buildCard("ece", "ECE"),
                                onTap: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    context: context,
                                    builder: ((builder) => popup(
                                        ece1sem,
                                        ece2sem,
                                        ece3sem,
                                        ece4sem,
                                        ece5sem,
                                        ece6sem,
                                        ece7sem,
                                        ece8sem)))),
                            GestureDetector(
                                child: buildCard("civil", "CIVIL"),
                                onTap: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    context: context,
                                    builder: ((builder) => popup(
                                        civil1sem,
                                        civil2sem,
                                        civil3sem,
                                        civil4sem,
                                        civil5sem,
                                        civil6sem,
                                        civil7sem,
                                        civil8sem)))),
                            GestureDetector(
                                child: buildCard("eee", "EEE"),
                                onTap: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    context: context,
                                    builder: ((builder) => popup(
                                        eee1sem,
                                        eee2sem,
                                        eee3sem,
                                        eee4sem,
                                        eee5sem,
                                        eee6sem,
                                        eee7sem,
                                        eee8sem)))),
                            GestureDetector(
                                child: buildCard("it", "IT"),
                                onTap: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    context: context,
                                    builder: ((builder) => popup(
                                        it1sem,
                                        it2sem,
                                        it3sem,
                                        it4sem,
                                        it5sem,
                                        it6sem,
                                        it7sem,
                                        it8sem)))),
                            GestureDetector(
                                child: buildCard("cse", "CSE"),
                                onTap: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    context: context,
                                    builder: ((builder) => popup(
                                        cse1sem,
                                        cse2sem,
                                        cse3sem,
                                        cse4sem,
                                        cse5sem,
                                        cse6sem,
                                        cse7sem,
                                        cse8sem)))),
                            GestureDetector(
                                child: buildCard("mech", "MECHANICAL"),
                                onTap: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25))),
                                    context: context,
                                    builder: ((builder) => popup(
                                        mech1sem,
                                        mech2sem,
                                        mech3sem,
                                        mech4sem,
                                        mech5sem,
                                        mech6sem,
                                        mech7sem,
                                        mech8sem)))),
                            GestureDetector(
                                child: buildCard("gate", "GATE"),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => displayPage(
                                            subj: "GATE", img: "gate")))),
                            GestureDetector(
                                child:
                                    buildCard("civilservice", "CIVIL SERVICE"),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => displayPage(
                                            subj: "CIVIL SERVICE",
                                            img: "civilservice")))),

                            // buildCard("ece", "ECE"),
                            // buildCard("civil", "CIVIL"),
                            // buildCard("eee", "EEE"),
                            // buildCard("it", "IT"),
                            // buildCard("cse", "CSE"),
                            // buildCard("mech", "MECHANICAL"),
                            // buildCard("gate", "GATE"),
                            // buildCard("civilservice", "CIVIL SERVICE")
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        //  height: 10,
                        //  width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: myColors.secondaryColor!,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 7), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          color: Colors.purple.shade50,
                          /*image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZnJlZSUyMGxpYnJhcnl8ZW58MHx8MHx8&w=1000&q=80"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black45, BlendMode.darken))*/

                          // color: Colors.tealAccent
                          // image: DecorationImage(
                          //    image: AssetImage("images/project/ece.jpg"),
                          //  fit: BoxFit.cover,
                          //colorFilter: ColorFilter.mode(
                          //     Colors.black45, BlendMode.darken))
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: buildAppbar(),

        // drawer: drawers(),

        /*  bottomNavigationBar: Theme(
        bottomNavigationBar: Theme(
    
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.black)),
          child: SafeArea(
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
    
              items: items,
              index: index,
              onTap: (index) => setState(() => this.index = index),
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              height: 60,
    
              buttonBackgroundColor: Colors.teal.shade100,
              buttonBackgroundColor: Colors.white,
    
    
              //color: Colors.transparent,
            ),
          ),
        ),*/
      ),
    );
  }

  Widget popup2() {
    return Container(
      color: Colors.indigo,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget popup(semester1, semester2, semester3, semester4, semester5, semester6,
      semester7, semester8) {
    return Card(
      color: Colors.white54,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        children: [
          Column(
            children: [
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 15.0,
                  color: Colors.indigo[400],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("FIRST SEMESTER"),
                      sizebox(),
                      dropdown(semester1),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 15.0,
                  color: Colors.indigo[400],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("SECOND SEMESTER"),
                      sizebox(),
                      dropdown(semester2),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.indigo[400],
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("THIRD SEMESTER"),
                      sizebox(),
                      dropdown(semester3),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.indigo[400],
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("FOURTH SEMESTER"),
                      sizebox(),
                      dropdown(semester4),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 15.0,
                  color: Colors.indigo[400],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("FIFTH SEMESTER"),
                      sizebox(),
                      dropdown(semester5),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.indigo[400],
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("SIXTH SEMESTER"),
                      sizebox(),
                      dropdown(semester6),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 15.0,
                  color: Colors.indigo[400],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("SEVENTH SEMESTER"),
                      sizebox(),
                      dropdown(semester7),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.indigo[400],
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800]!, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      sizebox(),
                      text("EIGTH SEMESTER"),
                      sizebox(),
                      dropdown(semester8),
                      sizebox(),
                    ],
                  ),
                ),
              ),
              sizebox(),
              sizebox(),
            ],
          )
        ],
      ),
    );
  }

  Widget sizebox() {
    return const SizedBox(height: 15);
  }

  void uploads() {}

  Widget divider() {
    return const Divider(
      thickness: 3,
      color: Colors.amber,
      height: 20,
    );
  }

  Widget text(sem) {
    return Text(
      sem,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white60),
    );
  }

  Widget dropdown(semesters) {
    if (same(semesters, ece1sem) ||
        same(semesters, ece2sem) ||
        same(semesters, ece3sem) ||
        same(semesters, ece4sem) ||
        same(semesters, ece5sem) ||
        same(semesters, ece6sem) ||
        same(semesters, ece7sem) ||
        same(semesters, ece8sem)) {
      dept = 'ece';
    } else if (same(semesters, eee5sem) ||
        same(semesters, eee1sem) ||
        same(semesters, eee2sem) ||
        same(semesters, eee3sem) ||
        same(semesters, eee4sem) ||
        same(semesters, eee6sem) ||
        same(semesters, eee7sem) ||
        same(semesters, eee8sem)) {
      dept = 'eee';
    } else if (same(semesters, civil1sem) ||
        same(semesters, civil2sem) ||
        same(semesters, civil3sem) ||
        same(semesters, civil4sem) ||
        same(semesters, civil5sem) ||
        same(semesters, civil6sem) ||
        same(semesters, civil7sem) ||
        same(semesters, civil8sem)) {
      dept = 'civil';
    } else if (same(semesters, it1sem) ||
        same(semesters, it2sem) ||
        same(semesters, it3sem) ||
        same(semesters, it4sem) ||
        same(semesters, it5sem) ||
        same(semesters, it6sem) ||
        same(semesters, it7sem) ||
        same(semesters, it8sem)) {
      dept = 'it';
    } else if (same(semesters, mech1sem) ||
        same(semesters, mech2sem) ||
        same(semesters, mech3sem) ||
        same(semesters, mech4sem) ||
        same(semesters, mech5sem) ||
        same(semesters, mech6sem) ||
        same(semesters, mech7sem) ||
        same(semesters, mech8sem)) {
      dept = 'mech';
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(20.0),
        child: DropdownButton<String>(
          hint: const Text("  Click Here"),
          onChanged: (String? newvalueselected) {
            setState(() {
              ece1 = newvalueselected!;
            });
          },
          items: semesters
              .map<DropdownMenuItem<String>>((String dropDownStringItem) {
            return DropdownMenuItem<String>(
                value: dropDownStringItem,
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               displayPage(subj: dropDownStringItem)));
                // },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => displayPage(
                                  subj: dropDownStringItem,
                                  img: dept,
                                )));
                  },
                  child: Text(
                    dropDownStringItem,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ));
          }).toList(),
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text(
        "VCET",
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
      ),
      elevation: 0,
      backgroundColor: myColors.secondaryColor,
      leading: MenuWidget(),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        IconButton(
          onPressed: () {
            //  Navigator.push(context,
            // MaterialPageRoute(builder: (context) => notification()));
          },
          icon: Icon(Icons.notification_important_rounded),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Image.asset(
                "images/logo1.webp",
                width: 33,
              ),
              onTap: () async {
                final url = 'http://vcet.ac.in';
                if (await canLaunch(url)) {
                  await launch(url, forceWebView: true, enableJavaScript: true);
                }
              },
            ),
            Padding(padding: EdgeInsets.only(top: 2)),
            const Text(
              "vcet web",
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    final shouldpop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldpop ?? false;
  }

  Card buildCard(String pic, String name) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //  padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image(
              image: AssetImage('images/project/$pic.jpg'),
              //fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ],
      ),
    );
  }
}
