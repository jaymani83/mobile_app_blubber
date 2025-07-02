
import 'package:flexiares/ticket_flow/create_ticket.dart';
import 'package:flexiares/ticket_flow/ticket_list_model.dart';

import 'package:flexiares/ui_values/controls_ui.dart';
import 'package:flexiares/utility/navigate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../services/api_network.dart';
import '../utility/functions.dart';
import 'ticket_log_list.dart';

class TicketList extends StatefulWidget {
  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {

  bool isDataLoading= false;
  List<TicketListModel> roomListModel = [];
  List<TicketListModel> orRoomListModel = [];
  bool showSearchBox = false;


  @override
  void initState() {
    super.initState();
    isDataLoading = true;
    getTicketData();
  }

  void getTicketData() async {
    orRoomListModel = await Services().getTicketList(context);
    roomListModel.addAll(orRoomListModel);
    print("******");
    print(roomListModel.length);
    setState(() {
      isDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      floatingActionButton: FloatingActionButton(
        /**
         * circular button to create a new ticket
         */
        backgroundColor: HexColor('#e2b616'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        onPressed: () async{
          //goToPage(context, CreateTicket());
          final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateTicket()),
          );

          // If a result is returned, update the UI
          if (result != null) {
            setState(() {
              isDataLoading = true;
              roomListModel.clear();
              orRoomListModel.clear();
              getTicketData();

            });
          }

        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
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
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                    ),
                    Text(
                      'Ticket List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
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
                      icon: Icon(Icons.filter_alt, color: Colors.white,),
                    ),
                  ],
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
                        (element.firstLog?.complaintDescription?.toLowerCase().contains(
                            value.toLowerCase())??false) ||
                            (element.owners?.firstName?.toLowerCase().contains(
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
                itemCount: roomListModel.length,
                itemBuilder: (context, index) {

                  TicketListModel ticket = roomListModel[index];
                  print('$index ${ticket?.taskDescriptionColor??''}');

                  return InkWell(
                    onTap: (){
                       goToPage(context, TicketLogList(ticketId: ticket.id.toString()));
                    },
                    child: Card(

                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                          Html(
                            data: ticket.firstLog?.complaintDescription??'',
                            // style: {
                            //   "html": Style(
                            //     color: HexColor(ticket.color??'#000000'),
                            //   ),
                            // },
                          ),
                            /**
                             * horizontal line
                             */
                            const Divider(color: Colors.black12,),
                          Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        ticket.overdueStatus ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: HexColor(ticket.taskDescriptionColor ?? '#000000'),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),

                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Assigned to: ${ticket.followed_name ?? ''}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor(ticket.taskDescriptionColor ?? '#000000'),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Visibility(
              visible: roomListModel.isEmpty && !isDataLoading,
              child: const Center(child: Text('No Ticket found'),),
            ),

          ],
        ),
      ),
    );
  }
}
