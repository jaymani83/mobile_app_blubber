
import 'package:flexiares/model/room_list_model.dart';

import 'package:flexiares/utility/constants.dart';
import 'package:flutter/material.dart';

import '../services/api_network.dart';
import '../ui_values/controls_ui.dart';
import '../utility/functions.dart';
import '../utility/navigate_page.dart';
import 'room_detail.dart';

class RoomListOne extends StatefulWidget {

  @override
  State<RoomListOne> createState() => _RoomListOneState();
}

class _RoomListOneState extends State<RoomListOne> {

  List<RoomListModel> roomListModel = [];
  List<RoomListModel> orRoomListModel = [];
  bool isDataLoading= false;
  bool showSearchBox = false;

  @override
  void initState() {
    super.initState();
    isDataLoading = true;
    getRoomData();
  }

  void getRoomData() async {
    orRoomListModel = await Services().getRoomList(context);
    roomListModel.addAll(orRoomListModel);
    setState(() {
      isDataLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    const Text('Meeting Rooms', style: TextStyle(fontSize: 24.0, color: Colors.white),),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showSearchBox = !showSearchBox;

                          if(showSearchBox==false){
                            roomListModel.clear();
                            roomListModel.addAll(orRoomListModel);
                          }
                        });
                      },
                      icon: const Icon(Icons.filter_alt, color: Colors.white,),
                    ),

                  ]
                ),
              ),
            ),

            Visibility(
              visible: showSearchBox,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),

                  onChanged: (value) {
                    setState(() {
                      if(value.isNotEmpty){
                        roomListModel = orRoomListModel.where((
                            element) =>
                        (element.location?.centre_name?.toLowerCase().contains(
                            value.toLowerCase())??false) ||
                            (element.location?.locality?.toLowerCase().contains(
                                value.toLowerCase())??false)).toList();

                      }
                      else {
                        roomListModel.clear();
                        roomListModel.addAll(orRoomListModel);
                      }
                    });
                  },
                ),
              ),
            ),

            isDataLoading ? const Center(child: CircularProgressIndicator(),) :
            Expanded(
              child: ListView.builder(
                itemCount: roomListModel?.length??0,
                itemBuilder: (context, index) {

                  RoomListModel roomListModel = this.roomListModel[index];
                  String locality = roomListModel.location?.locality??'';
                  if(locality.isNotEmpty) {
                    locality = '$locality, ';
                  }
                  String city = roomListModel.location?.city_name??'';
                  String person = (roomListModel?.max_capacity??0)>1?'Persons':'Person';


                  return InkWell(
                    onTap: () {
                      goToPage(context, RoomDetail(roomListModel: roomListModel,));
                    },
                    child: Card(
                      child: Row(
                        children: [
                          roomListModel.roomFiles?.isNotEmpty??false?
                          Container(
                            width: 124,
                            height: 136,
                            color: primaryColorLight, //the
                            child: Center(
                              child: Container(
                                width: 112,
                                height: 124,
                                child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.network(roomListModel.roomFiles?[0].public_url??'',)),
                              ),
                            ),
                          ):
                          Container(
                            width: 124,
                            height: 136,
                            color: primaryColorLight, //theme primary color,
                            child: Center(child: Image.asset('assets/meeting_room.png',height: 54,width: 54,)),
                          ),
                          //vSpacer(10.0),
                          Expanded(
                            child: Container(

                              color: Colors.white,
                              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    roomListModel?.location?.centre_name ?? '',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      decoration: TextDecoration.none,
                                      color: themeColor2,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),

                                  SizedBox(height: 8,),
                                  Text(
                                    '$locality$city',
                                    style: TextStyle(
                                      color: HexColor('#28427A'),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),

                                  Text(
                                    'Max : ${roomListModel?.max_capacity ?? "0"} $person',
                                    style: TextStyle(
                                      color: HexColor('#28427A'),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),

                                  SizedBox(height: 8,),

                                  Container(
                                    height: 54,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: roomListModel?.amenities?.length??0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: HexColor('#F3F6FD'),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: InkWell(
                                              onTap: null, // Replace with your desired callback if needed
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    endpoint + (roomListModel?.amenities?[index].icon_url ?? ''),
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                  if ((roomListModel?.amenities?[index].title ?? '').isNotEmpty)
                                                    Text(
                                                      roomListModel?.amenities?[index].title ?? '',
                                                      style: const TextStyle(fontSize: 12, color: Colors.black),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          )
                                          ,
                                        );
                                      },
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: roomListModel.isEmpty && !isDataLoading,
              child: const Center(child: Text('No Room Available'),),
            ),



          ],
        ),
      ),
    );
  }
}