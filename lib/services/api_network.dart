import 'dart:convert';
import 'dart:io';
import 'package:flexiares/model/business_location.dart';
import 'package:flexiares/model/login_model.dart';
import 'package:flexiares/model/room_list_bookdata_model.dart';
import 'package:flexiares/model/visitor_list_model.dart';
import 'package:flexiares/provider/login_provider.dart';
import 'package:flexiares/ticket_flow/ticket_list_model.dart';
import 'package:flexiares/ticket_flow/ticket_log_list_model.dart';
import 'package:provider/provider.dart';
import '../model/room_list_model.dart';
import '../utility/constants.dart';
import 'package:http/http.dart' as http;


class Services{

  Future<LoginModel> login(String username, String password,context)async{

    final requestBody = {
      'email': username,
      'password': password
    };
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(requestBody),
    );
    final decoded = jsonDecode(response.body);


    try {
      if ((decoded['data']) != null) {
        if (decoded['data'].containsKey('accessToken')) {
          return LoginModel.fromJson(decoded['data']);
        }
        else {
          return setLoginError(decoded);
        }
      }
      else {
        return setLoginError(decoded);
      }
    }
    catch (e) {
      return setLoginError(decoded);
    }

  }

  LoginModel setLoginError(decoded) {
      /**
     * set message and status code in login model
     */
    LoginModel loginModel=LoginModel();
    loginModel.statucode=401;
    loginModel.message=decoded[0];
    return loginModel;
  }


  Future<List<RoomListModel>> getRoomList(context)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';
    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }
      apiUrl=apiUrl+'/'+"api/v1";
    }


    String newRoomListUrl=apiUrl+ roomListUrl+'?paginate=no';

    final response = await http.get(
      Uri.parse(newRoomListUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final decoded = jsonDecode(response.body);
   RootRoomListModel? roomListModel= RootRoomListModel.fromJson(decoded);
    List<RoomListModel> list = [];
    list.addAll(roomListModel.roomList??[]);
    return list;
  }


  Future<List<RoomListBookDataModel>> getRoomBookList(context,String roomId,String tdate)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';

    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }


    String url=  bookingListUrl;

    url='$apiUrl$bookingListUrl?room_id=$roomId&booking_date=$tdate&paginate=no';


    final bundle = http.get(Uri.parse(url),
        headers: {
              'Authorization': 'Bearer $token'}
    );
    final response = await bundle;

    print(response);
    final decoded = jsonDecode(response.body);
    RootRoomListBookDataModel roomListModel= RootRoomListBookDataModel.fromJson(decoded);
    List<RoomListBookDataModel> list = [];
    list.addAll(roomListModel.data!);
    return list;
  }

  Future<String> postBookRoom(context,{required String roomId,
    required String tdate,required String startTime,required endTime,
    required person,
    required price,required comments})async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';

    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }


    /**
     * remove time from tdate
     *
     */
    tdate=tdate.split(' ')[0];
    print(tdate);

    /**
     * change start and end time into 24 hour format
     */
    startTime=changeTimeFormat(startTime);
    endTime=changeTimeFormat(endTime);



    String startDate= tdate+' '+startTime;
    String endDate= tdate+' '+endTime;
    String url=apiUrl +bookingListUrl+'?room_id=$roomId&startdate=$startDate&enddate=$endDate&price=$price&comments=$comments&person=$person';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Include this if you're sending JSON
      },
    );
    String msg= '';

    try {
      msg = jsonDecode(response.body)['error_msg'];
    }
    catch (e) {
      msg = '';
    }

    print("**********post*************");
    print(response);
    return msg;
  }



  Future<bool> postAddVisitor(context,{required String uname,
    required String mobile,required String email,required selDate,
    required selTime})async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';
    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }





    String url=apiUrl+visitorUrl;//"$visitorUrl?name=$uname&mobile=$mobile";
    // {name:jayvardhan pandey,email:jaymani.pandey@gmail.com,mobile: 9999190647,checkinDate: 15-04-2024,checkinTime: 12:00}

    final requestBody = {
      'name': uname,
      'email': email,
      'mobile': mobile,
      'checkinDate': selDate,
      'checkinTime': selTime
    };



    String requestBodyJson = json.encode(requestBody);

    try {

      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBodyJson,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        var responseData = json.decode(response.body);

        // Handle the response data as needed
        print(responseData);
      } else {
        // If the request was not successful, print the error message
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Print any exceptions that occur during the request
      print('Exception: $e');
    }

  return true;
  }


  Future<bool> deleteVisitor(context,String visitorId)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';
    bool isDeleted=false;
    /**
     * call http get request
     */
    try {

      String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
      if(apiUrl.isNotEmpty){

        if(!apiUrl.contains('http')){
          apiUrl='https://'+apiUrl;
        }

        apiUrl=apiUrl+'/'+"api/v1";
      }

      String url=apiUrl+'$visitorUrl/$visitorId';

      http.Response response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        var responseData = json.decode(response.body);

        // Handle the response data as needed
        print(responseData);

        if(responseData['message'].toString().toLowerCase().contains('deleted successfully')){
          isDeleted=true;
        }
        else{
          isDeleted=false;
        }
      } else {
        // If the request was not successful, print the error message
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Print any exceptions that occur during the request
      print('Exception: $e');
    }

    return isDeleted;

  }

  Future<bool> verifyVisitor(context,String tokenData)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';
    bool isDeleted=false;
    /**
     * call http get request
     */
    try {

      String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
      if(apiUrl.isNotEmpty){

        if(!apiUrl.contains('http')){
          apiUrl='https://'+apiUrl;
        }

        apiUrl=apiUrl+'/'+"api/v1";
      }


      String url=apiUrl+ visitorVerifyUrl;

      var bodyData = {
        'token': tokenData,
      };


      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(bodyData),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('VerifyVisitorData $url');
      print('VerifyVisitorData${response.body}');
      print('VerifyVisitorData$response');

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {

        var responseData = json.decode(response.body);
        print('VerifyVisitorData' + responseData);

        if(responseData['message'].toString().toLowerCase().contains('verified')){
          isDeleted=true;
        }
        else{
          isDeleted=false;
        }
      } else {
        // If the request was not successful, print the error message
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Print any exceptions that occur during the request
      print('Exception: $e');
    }

    return isDeleted;

  }

  Future<List<VisitorListModel>> getAllVisitorInfo(context)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';
    String locationId=Provider.of<LoginProvider>(context,listen: false).getLoginData().location_id.toString();
    String companyId=Provider.of<LoginProvider>(context,listen: false).getLoginData().company_id.toString();

    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }



    String url=visitorUrl;
    url=apiUrl+'$visitorUrl?location_id=$locationId&company_id=$companyId&per_page=20&page=1';

    final bundle = http.get(
      Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token'});

    final response = await bundle;
    print(response);
    final decoded = jsonDecode(response.body);
    RootVisitorListModel roomListModel= RootVisitorListModel.fromJson(decoded);
    List<VisitorListModel> list = [];
    list.addAll(roomListModel.data!);
    return list;
  }


  String changeTimeFormat(String startTime) {
    if (startTime.contains("am") || startTime.contains("pm")) {

      String time = startTime.split(' ')[0];
      String ampm = startTime.split(' ')[1];
      String hour = time.split(':')[0];
      String min = time.split(':')[1];
      if (ampm == 'PM') {
        hour = (int.parse(hour) + 12).toString();
      }
      return hour + ':' + min + ":00";
    }
    else
      {
        return startTime;
      }
  }


  Future<bool> createTicket(String information,File? _image,context)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';
    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }


    String newTicketCreateUrl='$apiUrl$ticketCreateUrl?other_description=$information';

    var request = http.MultipartRequest('POST', Uri.parse(newTicketCreateUrl));

    // Add text fields
    request.fields['other_description'] = information;

    // Add file
    if(_image!=null) {
      request.files.add(
          await http.MultipartFile.fromPath('image', _image!.path));
    }

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });
    var res = await request.send();
    if (res.statusCode == 200) {
      final response = await res.stream.bytesToString();
      final decoded = jsonDecode(response);

    try {
      if ((decoded['data']) != null) {
        return true;
      }
      else {
        return false;
      }
    }
    catch (e) {
      return false;
    }
    } else {
      print('Image not uploaded');
    }
    return false;
  }



  Future<List<TicketListModel>> getTicketList(context)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';
    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }


    /**
     * call http get request
     */
    String newRoomListUrl=apiUrl+ ticketListUrl+'?paginate=no';

    final bundle = http.get(
      Uri.parse(newRoomListUrl),
            headers: {
              'Authorization': 'Bearer $token'});
    final response = await bundle;

    final decoded = jsonDecode(response.body);
    RootTicketListModel ticketListModel= RootTicketListModel.fromJson(decoded);
    List<TicketListModel> list = [];
    list.addAll(ticketListModel.ticketList!);
    return list;
  }

  Future<List<BusinessLocation>> getBusinessLocation(context)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';

    /**
     * call http get request
     */

    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }

    String newRoomListUrl=apiUrl+ locationListUrl+'?paginate=no';
    final bundle = http.get(
      Uri.parse(newRoomListUrl),
            headers: {
              'Authorization': 'Bearer $token'});
    final response = await bundle;
    final decoded = jsonDecode(response.body);
    BusinessLocationListModel ticketListModel= BusinessLocationListModel.fromJson(decoded);
    List<BusinessLocation> list = [];
    list.addAll(ticketListModel.ticketList!);
    return list;
  }




  Future<TicketLogListModel> getTicketLogList(context,String ticketId)async{

    String? token= Provider.of<LoginProvider>(context, listen: false).getLoginData().token??'';

    /**
     * call http get request
     */

    String? apiUrl=Provider.of<LoginProvider>(context, listen: false).getLoginData().apiEndPoint??'';
    if(apiUrl.isNotEmpty){

      if(!apiUrl.contains('http')){
        apiUrl='https://'+apiUrl;
      }

      apiUrl=apiUrl+'/'+"api/v1";
    }

    String newRoomListUrl=apiUrl+'$ticketListUrl/$ticketId?paginate=no';
    final bundle = http.get(
        Uri.parse(newRoomListUrl),
        headers: {
          'Authorization': 'Bearer $token'});
    final response = await bundle;
    final decoded = jsonDecode(response.body);
    TicketLogListModel ticketLogListModel= TicketLogListModel.fromJson(decoded['data']);
    return ticketLogListModel;
  }

}