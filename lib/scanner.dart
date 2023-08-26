import 'package:flutter/material.dart';

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
        centerTitle: true,
        title: Text("QR바코드 스캔 결과"),
      ),
      body: FutureBuilder(
          future: _fetch1(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
            if (snapshot.hasData == false) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else{
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "제품명 : ${result['PRDLST_NM']}",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "식품유형 : ${result['PRDLST_DCNM']}",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "유통/소비기한 : ${result['POG_DAYCNT']}",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        height: 100,
                        width: 185,
                        alignment: Alignment.center,
                        child: Text(
                          "제조사\n\n${result['BSSH_NM']}",
                          style: TextStyle(color: Colors.white,fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        height: 100,
                        width: 185,
                        alignment: Alignment.center,
                        child: Text(
                          "업종\n\n${result['INDUTY_NM']}",
                          style: TextStyle(color: Colors.white,fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "주소 : ${result['SITE_ADDR']}",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "보고/신고일 : ${result['PRMS_DT'].toString().substring(0,4)}년 ${result['PRMS_DT'].toString().substring(4,6)}월 ${result['PRMS_DT'].toString().substring(6,8)}일",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "보고(신고)번호 : ${result['PRDLST_REPORT_NO']}",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "식품(첨가물)원재료\n\n${result2['RAWMTRL_NM']}",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
          }
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pop(context);
        },
        label: Text("뒤로가기"),
      ),
    );
  }
  Future<String> _fetch1() async {
    result = await barcode_food(widget.barcode);
    result2 = await food_history(result['PRDLST_REPORT_NO']);
    await Future.delayed(Duration(seconds: 3));
    return "calldata";
  }
}
