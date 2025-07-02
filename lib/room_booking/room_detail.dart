import 'package:flexiares/model/room_list_model.dart';
import 'package:flexiares/ui_values/space_ui.dart';
import 'package:flexiares/utility/color_scheme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/room_list_bookdata_model.dart';
import '../services/api_network.dart';
import '../ui_values/controls_ui.dart';
import '../utility/functions.dart';

class RoomDetail extends StatefulWidget {

  final RoomListModel? roomListModel;

  const RoomDetail({super.key, this.roomListModel});

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {

  bool isReviewShowing  = false;
  bool isFinalBooking = false;
  late DateTime _selectedDate;
  late TimeOfDay _selectedStartTime;
  late TimeOfDay _selectedEndTime;

  String _selectedStartTimeStr = '';
  String _selectedEndTimeStr = '';

  final int _totalHours = 24;

  double containerWidth = 80.0;
  List<RoomListBookDataModel> roomListBookDataModel = [];
  bool isDataLoading= false;

  final List<String> displayTimes = [
    '07:00 - 07:30',
    '07:30 - 08:00',
    '08:00 - 08:30',
    '08:30 - 09:00',
    '09:00 - 09:30',
    '09:30 - 10:00',
    '10:00 - 10:30',
    '10:30 - 11:00',
    '11:00 - 11:30',
    '11:30 - 12:00',
    '12:00 - 12:30',
    '12:30 - 13:00',
    '13:00 - 13:30',
    '13:30 - 14:00',
    '14:00 - 14:30',
    '14:30 - 15:00',
    '15:00 - 15:30',
    '15:30 - 16:00',
    '16:00 - 16:30',
    '16:30 - 17:00',
    '17:00 - 17:30',
    '17:30 - 18:00',
    '18:00 - 18:30',
    '18:30 - 19:00',
    '19:00 - 19:30',
    '19:30 - 20:00',
    '20:00 - 20:30',
    '20:30 - 21:00',
    '21:00 - 21:30',
    '21:30 - 22:00',
    '22:00 - 22:30',
    '22:30 - 23:00',
    '23:00 - 23:30',
    '23:30 - 24:00'
  ];
  final List<String> dropDownSelTimes = [
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
    '23:30'
  ];

  final List<String> apiSelectedTimes = [];
  final List<String> userSelectedTimes = [];
  final List<Color> userSelectedTimesColor = [];
  List<String> highlightTimes = [];

  double bookingPrice = 0.0;
  List<String> listCapacity=[];
  String selectedPerson='1';

  bool isHighLightTimesLoading = false;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String todayDate = DateTime.now().toString();
    _selectedDate = DateTime.parse(todayDate.substring(0,10));


    _selectedStartTime = TimeOfDay.now();
    _selectedEndTime = TimeOfDay.now();//.add(Duration(hours: 1));


    int maxCapacity = widget.roomListModel?.max_capacity??0;
    for(int i=1;i<=maxCapacity;i++){
      listCapacity.add(i.toString());
    }


    displayTimes.forEach((element) {
      userSelectedTimesColor.add(Colors.white);
    });
       setDateData(_selectedDate.toString());
  }


  void setDateData(String selDate){

    setState(() {
      highlightTimes.clear();

      for(int i=0;i<userSelectedTimesColor.length;i++){
        userSelectedTimesColor[i] = Colors.white;
      }

     _selectedDate = DateTime.parse(selDate.substring(0,10));

      isHighLightTimesLoading = true;
    });

    getRoomData();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: customAppBar(context),
        body: WillPopScope(
          onWillPop: () async {
            if(isReviewShowing){
              setState(() {
                isReviewShowing = false;
              });
            }
            else if(isFinalBooking){
              Navigator.pop(context);
            }
            else {
              Navigator.pop(context);
            }
            return false;
          },
          child: SafeArea(
          child: Container(
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                  child: Container(
                    height: 72.0,
                    color: HexColor('#011630'),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                          ),

                          Visibility(
                              visible: isReviewShowing && !isFinalBooking,
                              child: Expanded(child: Center(child: Text('Review your booking',style: TextStyle(fontSize: 24.0,color: Colors.white),)))),

                          Visibility(
                            visible: !isReviewShowing && !isFinalBooking,
                           child:
                             Expanded(child: Center(child: Text( widget.roomListModel?.name.toString()??'', style: TextStyle(fontSize: 24.0, color: Colors.white),))),
                            ),

                          Visibility(
                              visible: isFinalBooking,
                              child: Expanded(child: Center(child: Text('Booking Status',style: TextStyle(fontSize: 24.0,color: Colors.white),)))),


                        ]
                    ),
                  ),
                ),

                SizedBox(height: 12,),
                /**
                 * set allset image and text
                 */
                isFinalBooking?Container():
                corouselImage(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [



                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                        child: Container(
                          //height: 72.0,
                          padding: EdgeInsets.all(12.0),
                          color: HexColor('#ffffff'),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [


                              Visibility(
                                  visible: isFinalBooking,
                                  child: Image.asset('assets/allset.png',height: 100,width: 100,)),
                              Visibility(
                                  visible: isFinalBooking,
                                  child: Center(child: Text('Great, You are all set!!!',style: TextStyle(fontSize: 24.0,color: Colors.black),))),


                              SizedBox(height: 20.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: Colors.blue,),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Text(
                                      widget.roomListModel?.location?.location_address.toString()??'',
                                      style: TextStyle(fontSize: 16.0,color: Colors.black45),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24,),

                              Text(
                                widget.roomListModel?.description??'Details about the meeting room',
                                style: TextStyle(fontSize: 16.0,color: Colors.black45),
                              ),


                              SizedBox(height: 24,),
                              const Text('My Booking',style: TextStyle(fontSize: 18.0,color: Colors.black),),


                              /**
                               * show dropdown of max capacity
                               */
                              Visibility(
                                visible: false,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  decoration: BoxDecoration(
                                    color: HexColor('#F2F2F2'),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Max Capacity',style: TextStyle(fontSize: 16.0,color: Colors.black45),),
                                      Text('${widget.roomListModel?.max_capacity} person',style: TextStyle(fontSize: 16.0,color: Colors.black45),),
                                    ],
                                  ),
                                ),
                              ),

                              /**
                               * show spinner of max capacity
                               */
                              SizedBox(height: 12,),
                              Container(
                                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                decoration: BoxDecoration(
                                  color: HexColor('#F2F2F2'),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(isFinalBooking?'Person':'Select Person',style: TextStyle(fontSize: 16.0,color: Colors.black45),),

                                    isFinalBooking?
                                    Text(selectedPerson,style: TextStyle(fontSize: 16.0,color: Colors.black45),):
                                    DropdownButton<String>(
                                      value: selectedPerson,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.black),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedPerson = newValue!;
                                        });
                                      },
                                      items: listCapacity
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),


                                  ],
                                ),
                              ),

                              SizedBox(height: 12,),
                          Container(
                            padding: EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                              color: HexColor('#F2F2F2'),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if(isFinalBooking){
                                          return;
                                        }
                                        _selectDate(context);
                                      },
                                      child: Container(

                                        //padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Text('Date',style: TextStyle(fontSize: 16.0,color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Text(
                                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                              style: TextStyle(fontSize: 16.0,color: Colors.black45)),
                                            ],
                                            ),),
                                      ),
                                    ),

                                  const VerticalDivider(
                                    color: Colors.black45,
                                    thickness: 1,
                                    width: 2,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        //_selectStartTime(context);
                                        //show drop down of the times from dropDownSelTimes
                                        if(isFinalBooking){
                                          return;
                                        }
                                        showCustomDialog(context, dropDownSelTimes, 'Start Time');
                                      },
                                      child: Container(
                                        // color: Colors.green,
                                        // padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: [

                                            Text('Start Time',style: TextStyle(fontSize: 16.0,color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Text(
                                              '${_selectedStartTime.format(context)}',
                                              style: TextStyle(color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black45,
                                    thickness: 1,
                                    width: 2,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                       // _selectEndTime(context);
                                        if(isFinalBooking){
                                          return;
                                        }
                                        showCustomDialog(context, dropDownSelTimes, 'End Time');
                                      },
                                      child: Container(
                                        // color: Colors.orange,
                                        // padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Text('End Time',style: TextStyle(fontSize: 16.0,color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Text(
                                               '${_selectedEndTime.format(context)}',
                                              style: TextStyle(color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                              SizedBox(height: 24,),

                          isReviewShowing?Container():
                          isHighLightTimesLoading?Center(child: CircularProgressIndicator(),):
                          Container(
                                padding: const EdgeInsets.all(12.0),
                                height: 124,
                                //width: double.infinity,
                                decoration: BoxDecoration(
                                  color: HexColor('#F2F2F2'),
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: displayTimes!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    // final hour = index % 12 == 0 ? 12 : index % 12;
                                    // final period = index < 12 ? 'AM' : 'PM';

                                    /**
                                     * remove string after @@@ and get only time in hh:mm format
                                     */


                                    Color? bgColor=Colors.white;

                                    List<String> hAllTime=displayTimes[index].split("-");
                                    String hTime1=hAllTime[0].toString();
                                    String hTime2=hAllTime[1].toString();

                                    bool isEnable = true;
                                    if(highlightTimes.isNotEmpty) {
                                      highlightTimes.forEach((element) {
                                        List<String>dt = element.split('@@@');
                                        String hTime = dt[0].toString();

                                        List<
                                            String> displayTimeList = displayTimes[index]
                                            .split('-');
                                        hTime1 =
                                            displayTimeList[0].toString().trim();
                                        hTime2 =
                                            displayTimeList[1].toString().trim();

                                        if (hTime1.contains(hTime)) {

                                          userSelectedTimesColor[index] = CustomColorScheme.highTextColor;
                                          isEnable = false;
                                        }
                                      });

                                      userSelectedTimes.forEach((element) {
                                        if (element.contains(displayTimes[index])) {

                                          bgColor = Colors.green;

                                        }
                                      });


                                    }
                                    return InkWell(
                                      onTap: () {
                                        /**
                                         * check if time slot is already selected then remove from list
                                         */

                                        if(!isEnable){
                                          return;
                                        }
                                        if(userSelectedTimes.contains(displayTimes[index])) {
                                          userSelectedTimes.remove(
                                              displayTimes[index]);
                                          setState(() {
                                            userSelectedTimesColor[index] = Colors.white;
                                            bgColor = Colors.white;
                                          });
                                        }
                                        else {
                                          /**
                                           * check if time slot is already booked then do not allow to select
                                           */
                                          if(apiSelectedTimes.length>0) {
                                            apiSelectedTimes.forEach((element) {
                                              print('fcTime Slot: $element');
                                              print(
                                                  'fcdTime Slot: ${displayTimes[index]}');
                                            });


                                            if (apiSelectedTimes.contains(
                                                displayTimes[index])) {
                                              return;
                                            }
                                            else {
                                              userSelectedTimes.add(
                                                  displayTimes[index]);
                                              setState(() {
                                                bgColor = Colors.green;
                                              });
                                            }
                                          }
                                          else {
                                            userSelectedTimes.add(
                                                displayTimes[index]);
                                            setState(() {
                                              bgColor = Colors.green;
                                              userSelectedTimesColor[index] = Colors.green;
                                            });
                                          }


                                        }

                                        getBookingPrice();

                                        /**
                                         * get min and max time from userSelectedTimes and set to _selectedStartTime and _selectedEndTime
                                         */
                                        if(userSelectedTimes.isNotEmpty) {
                                          List<String> minMaxTime=[];
                                          List<String> maxTime=[];
                                          if(userSelectedTimes.length==1){
                                            minMaxTime = userSelectedTimes[0].split('-');

                                            _selectedStartTime = TimeOfDay(
                                                hour: int.parse(minMaxTime[0].split(':')[0]),
                                                minute: int.parse(minMaxTime[0].split(':')[1]));

                                            _selectedEndTime = TimeOfDay(
                                                hour: int.parse(minMaxTime[1].split(':')[0]),
                                                minute: int.parse(minMaxTime[1].split(':')[1]));
                                          }
                                          else
                                          {

                                            userSelectedTimes.sort();
                                            minMaxTime = userSelectedTimes[0].split('-');
                                            maxTime = userSelectedTimes[userSelectedTimes.length-1].split('-');

                                            _selectedStartTime = TimeOfDay(
                                                hour: int.parse(minMaxTime[0].split(':')[0]),
                                                minute: int.parse(minMaxTime[0].split(':')[1]));

                                            _selectedEndTime = TimeOfDay(
                                                hour: int.parse(maxTime[1].split(':')[0]),
                                                minute: int.parse(maxTime[1].split(':')[1]));


                                          }



                                        }
                                      },
                                      child: Container(
                                        width: 72,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: userSelectedTimesColor[index],
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "$hTime1\n  -\n$hTime2",
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),


                              /**
                               * multiline text box with hint text to write comment
                               */
                              Visibility(
                                visible: isReviewShowing && isFinalBooking==false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    SizedBox(height: 6,),
                                    Text('Special Instruction',style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),

                                    Container(
                                      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                      decoration: BoxDecoration(
                                        color: HexColor('#FfFfFf'),
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: Border.all(color: Colors.black45),
                                      ),
                                      child: TextField(
                                        controller: commentController,
                                        maxLines: 3,
                                        keyboardType: TextInputType.text,

                                      ),
                                    ),
                                  ],
                                ),
                              ),


                            isFinalBooking?Container():
                            const SizedBox(height: 6.0),

                            Container(
                            padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
                            decoration: BoxDecoration(
                              color: HexColor('#F2F2F2'),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Rs $bookingPrice',style: const TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 2,),
                                      const Text(
                                        '+ taxes',
                                        style: TextStyle(fontSize: 14.0,color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),



                                Visibility(
                                  visible: !isFinalBooking,
                                  child: Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (isReviewShowing) {
                                            callRoomBooking();
                                          } else {
                                            callReviewBooking();
                                          }
                                        },
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: CustomColorScheme.btnColor,
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isReviewShowing ? 'Confirm Booking' : 'Book Now',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      ,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                           Visibility(
                                visible: isFinalBooking && commentController.text.toString().isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    SizedBox(height: 12,),
                                    Text('Special Instruction',style: TextStyle(fontSize: 16.0,color: Colors.black),),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      decoration: BoxDecoration(
                                        color: HexColor('#F2F2F2'),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Text(commentController.text??'-',style: TextStyle(fontSize: 16.0,color: Colors.black45),),
                                    ),
                                  ],
                                ),
                              ),




                            ],
                          ),


                        ),
                      ),




                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
        ),
    );

  }

  Widget corouselImage(){
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 0.08* MediaQuery.of(context).size.height,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16/9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.3,
        ),
        items: widget.roomListModel?.roomFiles?.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: 0.3* MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Image.network(
                  imageUrl?.public_url??'',
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  void callReviewBooking() {

    if (_selectedDate.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select valid date'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (userSelectedTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select time slot'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (_selectedEndTime.hour < _selectedStartTime.hour) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('End time should be greater than start time'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }


    setState(() {
      isReviewShowing = true;
    });
  }

  void callRoomBooking() async {
    isDataLoading = true;
    String roomId= widget.roomListModel?.id.toString()??'';
    String tdate= _selectedDate.toString();

    String sHour=_selectedStartTime.hour.toString().length==1?'0'+_selectedStartTime.hour.toString():_selectedStartTime.hour.toString();
    String sMin=_selectedStartTime.minute.toString().length==1?'0'+_selectedStartTime.minute.toString():_selectedStartTime.minute.toString();
    String startTime = "$sHour:$sMin";//_selectedStartTimeStr+":00";

    String eHour=_selectedEndTime.hour.toString().length==1?'0'+_selectedEndTime.hour.toString():_selectedEndTime.hour.toString();
    String eMin=_selectedEndTime.minute.toString().length==1?'0'+_selectedEndTime.minute.toString():_selectedEndTime.minute.toString();
    String endTime = "$eHour:$eMin";//_selectedEndTimeStr+":00";

    String person = selectedPerson;
    String price = bookingPrice.toString();
    String comments = 'Booking from app';
    if(commentController.text.isNotEmpty) {
      comments = commentController.text;
    }

    String isBooked = await Services().postBookRoom(context,roomId: roomId,tdate: tdate,startTime: startTime,endTime: endTime,person: person,price: price,comments: comments);

    if(isBooked.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Room booked successfully'),
          duration: Duration(seconds: 3),
        ),
      );

      setState(() {
        isFinalBooking = true;
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isBooked??'Error in booking room'),
          duration: Duration(seconds: 3),
        ),
      );

    }

    setState(() {
      isDataLoading = false;
    });
  }

  void getHightLightTimes(){

    roomListBookDataModel.forEach((element) {

      try {
        DateTime start = DateTime.parse(element.booking_start_time!);
        DateTime end = DateTime.parse(element.booking_end_time!);
       String min = start.minute
              .toString()
              .length == 1 ? '0' + start.minute.toString() : start.minute
              .toString();

          String hr = start.hour
              .toString()
              .length == 1 ? '0' + start.hour.toString() : start.hour
              .toString();
String endmin = end.minute
              .toString()
              .length == 1 ? '0' + end.minute.toString() : end.minute
              .toString();

          String ehr = end.hour
              .toString()
              .length == 1 ? '0' + end.hour.toString() : end.hour
              .toString();

          while(start.isBefore(end)) {

              String min = start.minute
                  .toString()
                  .length == 1 ? '0' + start.minute.toString() : start.minute
                  .toString();
              highlightTimes.add(
                  '${start.hour}:${min}@@@${element.status_color ?? '#5bc0de'}');

              start = start.add(const Duration(minutes: 30));
            }

      }
      catch(e){
        print('RoomDetailError: $e');
      }

    });


    highlightTimes.forEach((element) {
      print('highLight Times123: $element');
    });

  }

  Widget _buildTimeSlots() {
    // Define the start and end times
    final DateTime startTime = DateTime(2024, 2, 19, 14, 30); // 2:30 PM
    final DateTime endTime = DateTime(2024, 2, 19, 17, 0); // 5:00 PM

    // Define the time slot (30 minutes in this example)
    const Duration timeSlot = Duration(minutes: 30);

    // Calculate the number of slots
    final int slotCount = (endTime.difference(startTime).inMinutes / timeSlot.inMinutes).toInt();

    // Generate the time slots
    final List<String> timeSlots = List.generate(slotCount, (index) {
      final DateTime slotStart = startTime.add(Duration(minutes: index * timeSlot.inMinutes));
      final DateTime slotEnd = slotStart.add(timeSlot);
      return '${_formatTime(slotStart)} - ${_formatTime(slotEnd)}';
    });

    // Display the time slots
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(timeSlots[index]),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  void getRoomData() async {
    isDataLoading = true;
    String roomId= widget.roomListModel?.room_id.toString()??'';
    String tdate= _selectedDate.toString();
    roomListBookDataModel = await Services().getRoomBookList(context,roomId,tdate);


    if(roomListBookDataModel.isNotEmpty) {
      getHightLightTimes();
    }

    setState(() {
      isDataLoading = false;
      isHighLightTimesLoading = false;
    });
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
    setDateData(_selectedDate.toString());
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  void getBookingPrice(){
    double tempBPrice = 0.0;
    double bookingHour = ((userSelectedTimes.length)/2);

    double hourPrice = double.parse(widget.roomListModel?.hour_price??'0.0');
    double halfPrice = double.parse(widget.roomListModel?.half_price??'0.0');
    double fullPrice = double.parse(widget.roomListModel?.full_price??'0.0');

    if (kDebugMode) {
      print('RoomDetail: $bookingHour');
      print('RoomDetail: $hourPrice');
      print('RoomDetail: $halfPrice');
    }


    if(bookingHour < 4){
      tempBPrice = hourPrice * bookingHour ;
    }
    if((bookingHour >= 4) && (bookingHour < 8)){
      var halfDay = 1;
      var hr = bookingHour - 4;
      tempBPrice = (halfPrice * halfDay) + (hourPrice * hr) ;
    }

    if(bookingHour >= 8 && (bookingHour < 20)){
      var fullDay = 1;
      tempBPrice = fullPrice * fullDay ;
    }

    if(bookingHour > 20 ){
      var fullDay = 1;
      tempBPrice = fullPrice * fullDay * bookingHour;
    }

    setState(() {
      bookingPrice = tempBPrice;
    });



  }


  showCustomDialog(BuildContext context, List<String> list, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: 300,
            height: 300,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list[index]),
                  onTap: () {
                    Navigator.pop(context);

                    int startIndex=0;
                    int endIndex=0;
                    setState(() {
                      if(title == 'Start Time'){
                      _selectedStartTimeStr = list[index];

                        _selectedStartTime = TimeOfDay(
                            hour: int.parse(list[index].split(':')[0]),
                            minute: int.parse(list[index].split(':')[1]));

                        /**
                         * check if start time is greater than end time then set end time to start time + 30 minutes
                         */
                        if(_selectedStartTime.hour > _selectedEndTime.hour) {
                          _selectedEndTime = TimeOfDay(
                              hour: _selectedStartTime.hour,
                              minute: _selectedStartTime.minute + 30);
                        }
                      }
                      else {
                        _selectedEndTimeStr = list[index];

                        _selectedEndTime = TimeOfDay(
                            hour: int.parse(list[index].split(':')[0]),
                            minute: int.parse(list[index].split(':')[1]));

                        /**
                         * check if end time is less than start time then set start time to end time - 30 minutes
                         */
                        if(_selectedEndTime.hour < _selectedStartTime.hour) {
                          _selectedStartTime = TimeOfDay(
                              hour: _selectedEndTime.hour,
                              minute: _selectedEndTime.minute - 30);
                        }


                        userSelectedTimes.clear();
                        for(int i=0;i<userSelectedTimesColor.length;i++){
                          userSelectedTimesColor[i] = Colors.white;
                        }
                  String sTime = _selectedStartTime.format(context).replaceAll("AM", "");
                        sTime = sTime.replaceAll("PM", "");
                        String eTime = _selectedEndTime.format(context).replaceAll("AM", "");
                        eTime = eTime.replaceAll("PM", "");

                        displayTimes.forEach((element) {

                          String displaySTime = element.split('-')[0].trim();
                          String displayETime = element.split('-')[1].trim();

                          if(displaySTime.trim()==sTime.trim())startIndex = displayTimes.indexOf(element);

                          if(displayETime.trim()==eTime.trim()) endIndex = displayTimes.indexOf(element);



                        });

                        for(int i=startIndex;i<=endIndex;i++){
                          userSelectedTimes.add(displayTimes[i]);
                          userSelectedTimesColor[i] = Colors.green;
                        }

                        userSelectedTimes.forEach((element) {
                          print('RoomDetailUSel: $element');
                        });

                        getBookingPrice();
                      }
                    });


                  },
                );
              },
            ),
          ),
        );
      },
    );
  }


}
