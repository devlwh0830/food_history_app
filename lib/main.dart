import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_history_app/scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          fontFamily: "GmarketSansTTF",
        ),
        home:  MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';

  onButtonTap() async {
    await launchUrlString("https://www.foodsafetykorea.go.kr/minwon/complain/complainIntro.do",mode: LaunchMode.platformDefault);
  }

  onButtonTap1() async {
    await launchUrlString("https://www.foodsafetykorea.go.kr/portal/board/boardDetail.do?menu_no=3120&menu_grp=MENU_NEW01&bbs_no=bbs001&ntctxt_no=1091412",mode: LaunchMode.platformDefault);
  }

  void toast(){
    Fluttertoast.showToast(
        msg: "외부 사이트로 이동합니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', '돌아가기', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = '에러가 발생 했습니다.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if(barcodeScanRes != "-1") Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner_Page(barcode: barcodeScanRes)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(''),
              centerTitle: true,
              backgroundColor: Color.fromRGBO(255, 230, 199, 1),
              elevation: 0.0,
            ),
            body: Builder(builder: (BuildContext context) {
              return Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 230, 199, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    ),
                    height: 300,
                    child: Image.asset("assets/image/main.png")
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 200),
                    height: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        0,
                                        5,
                                      )
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(top: 30,right: 20,left: 20),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Image.asset("assets/image/scan.png"),
                                    onTap: ()=>scanQR(),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        alignment: Alignment.center,
                                        width: 190,
                                        child: Text(
                                          " QR 또는 바코드로\n식품 정보 확인하기",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "GmarketSansTTF",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 90,),
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: IconButton(
                                          onPressed: () => scanQR(),
                                          icon: Icon(Icons.arrow_forward_outlined,size: 60,),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                        ),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade50,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        0,
                                        5,
                                      )
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(top: 20,right: 20,left: 20,bottom: 10),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Image.asset("assets/image/check_list.png"),
                                    onTap: (){
                                      toast();
                                      onButtonTap1();
                                    },
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        alignment: Alignment.center,
                                        width: 190,
                                        child: Text(
                                          "식품의 알레르기 정보\n확인하기",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "GmarketSansTTF",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 90,),
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: IconButton(
                                          onPressed: (){
                                            toast();
                                            onButtonTap1();
                                          },
                                          icon: Icon(Icons.arrow_forward_outlined,size: 60,),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                        ),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        0,
                                        5,
                                      )
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(top: 10,right: 20,left: 20,bottom: 20),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Image.asset("assets/image/siren.png"),
                                    onTap: (){
                                      toast();
                                      onButtonTap();
                                    },
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        alignment: Alignment.center,
                                        width: 190,
                                        child: Text(
                                          "부정, 불량, 위험식품\n신고하기",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "GmarketSansTTF",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 90,),
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: IconButton(
                                          onPressed: (){
                                            toast();
                                            onButtonTap();
                                          },
                                          icon: Icon(Icons.arrow_forward_outlined,size: 60,),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          )
        )
    );
  }
}