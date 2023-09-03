import 'dart:convert';
import 'package:http/http.dart' as http;

barcode_food(String number) async { // 버스 노선 조회 API
  var result = await http.get(
      Uri.parse('http://openapi.foodsafetykorea.go.kr/api/8bcb4193b5504de09568/C005/json/1/1/BAR_CD=$number'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var a = jsonDecode(result.body);
    if(a['C005']['RESULT']['MSG'].toString() == "해당하는 데이터가 없습니다."){
      return a['C005']['RESULT']['MSG'];
    }else{
      return a['C005']['row'][0];
    }
  }
}
food_history(String number) async { // 버스 노선 조회 API
  var result = await http.get(
      Uri.parse('http://openapi.foodsafetykorea.go.kr/api/8bcb4193b5504de09568/C002/json/1/5/PRDLST_REPORT_NO=$number'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var a = jsonDecode(result.body);
    return a['C002']['row'][0];
  }
}
