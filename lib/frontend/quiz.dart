import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcet/colorClass.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    String cplusplus = "https://xaviergreer.com/static/images/cplus.png";
    String c =
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/C_Programming_Language.svg/1200px-C_Programming_Language.svg.png";
    String java =
        "https://cdn.vox-cdn.com/thumbor/_AobZZDt_RVStktVR7mUZpBkovc=/0x0:640x427/1200x800/filters:focal(0x0:640x427)/cdn.vox-cdn.com/assets/1087137/java_logo_640.jpg";
    String python =
        "https://localist-images.azureedge.net/photos/31583518696354/original/0135374d81d3481dd24228d0deea271b904000a5.png";
    String javascript =
        'http://code-institute-org.github.io/Full-Stack-Web-Developer-Stream-0/assets/javascript.png';

    String cweb =
        "https://online-test.w3schools.in/practice-tests/c-programming/";
    String pythonweb = "https://www.w3schools.com/python/python_quiz.asp";
    String javaweb = "https://www.w3schools.com/java/java_quiz.asp";
    String jsweb = "https://www.w3schools.com/js/js_quiz.asp";
    String cplusplusweb = "https://www.w3schools.com/cpp/cpp_quiz.asp";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QUIZ",
          style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
        backgroundColor: myColors.secondaryColor,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          webcard("C LANGUAGE", c, cweb, true),
          webcard("PYTHON", python, pythonweb, true),
          webcard("JAVA", java, javaweb, true),
          webcard("c++", cplusplus, cplusplusweb, true),
          webcard("JAVA SCRIPT", javascript, jsweb, true),
        ],
      ),
    );
  }

  Widget webcard(name, url, web, boolean) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () async {
          // final url = 'http://vcet.ac.in';
          if (await canLaunch(web)) {
            await launch(web, forceWebView: boolean, enableJavaScript: boolean);
          }
        },
        child: Card(
          color: Colors.cyan,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),

          elevation: 20,
          // color: Colors.amber,
          shadowColor: Colors.black54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(url),
                ),
              ),
              Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.arrow_forward_ios_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
