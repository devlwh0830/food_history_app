import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'api.dart';

class Scanner_Page extends StatefulWidget {
  const Scanner_Page({super.key, this.barcode});
  final barcode;

  @override
  State<Scanner_Page> createState() => _Scanner_PageState();
}

class _Scanner_PageState extends State<Scanner_Page> {

  var result;
  var result2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 230, 199, 1),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 230, 199, 1),
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
              height: 150,
              child: Image.asset("assets/image/result_main.png")
          ),
          FutureBuilder(
              future: _fetch1(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                if (snapshot.hasData == false) {
                  return Container(
                    height: 620,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text("\n\n조회하고 있습니다.\n최대 10초가 소요될 수 있습니다.",style:TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                      ],
                    ),
                  );
                } else{
                  return Container(
                    height: 620,
                    child: ListView(
                      children: [
                        if(result != "해당하는 데이터가 없습니다.")...[
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10,top: 20),
                                height: 30,
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "이 식품은 \"${result['BSSH_NM']}\"에서 만든",
                                  style: TextStyle(color: Colors.black,fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 30,
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "\"${result['PRDLST_NM']}\" 이라는 제품이에요.",
                                  style: TextStyle(color: Colors.black,fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                height: 50,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "식품유형은 \"${result['PRDLST_DCNM']}\"로 분류 되어있어요.",
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                ),
                              ),Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade50,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                height: 80,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "📅 유통/소비기한은\n${result['POG_DAYCNT']} 이에요.",
                                  style: TextStyle(color: Colors.black,fontSize: 18),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                height: 70,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "${result['BSSH_NM']}은\n\"${result['INDUTY_NM']}\"으로 신고📄 되어 있어요.",
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade50,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                height: 60,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "이 식품이 생산된 🚩장소에요.\n${result['SITE_ADDR']}",
                                  style: TextStyle(color: Colors.black,fontSize: 18),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding:EdgeInsets.only(right: 25),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                height: 60,
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "처음으로 보고 또는 신고된 날짜는\n${result['PRMS_DT'].toString().substring(0,4)}년 ${result['PRMS_DT'].toString().substring(4,6)}월 ${result['PRMS_DT'].toString().substring(6,8)}일 이에요",
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding:EdgeInsets.only(left: 25),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade50,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                height: 60,
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "보고(신고)🏢번호는\n\"${result['PRDLST_REPORT_NO']}\" 이에요.",
                                  style: TextStyle(color: Colors.black,fontSize: 18),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                height: 300,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "이 식품의 (첨가물)원재료는\n\n${result2['RAWMTRL_NM']}\n\n이라고 적혀있어요.",
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ]else...[
                          Container(
                            margin: EdgeInsets.only(top: 300),
                            alignment: Alignment.center,
                            child: Text("😢 조회할 수 있는 식품 정보가 없어요.",style: TextStyle(fontSize: 20),),
                          )
                        ]
                      ],
                    ),
                  );
                }
              }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          launchUrlString("tel://1399");
        },
        icon: Icon(Icons.report_gmailerrorred_rounded,size: 25,),
        label: Text("신고하기"),
      ),
    );
  }
  Future<String> _fetch1() async {
    result = await barcode_food(widget.barcode);
    if(result != "해당하는 데이터가 없습니다."){
      result2 = await food_history(result['PRDLST_REPORT_NO']);
    }
    await Future.delayed(Duration(seconds: 1));
    return "calldata";
  }
}
