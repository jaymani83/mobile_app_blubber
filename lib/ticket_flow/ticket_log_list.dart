
import 'package:flexiares/ticket_flow/ticket_log_list_model.dart';
import 'package:flexiares/ui_values/space_ui.dart';
import 'package:flexiares/utility/color_scheme.dart';
import 'package:flexiares/utility/functions.dart';
import 'package:flutter/material.dart';

import '../services/api_network.dart';

class TicketLogList extends StatefulWidget {
  final String ticketId;

  TicketLogList({Key? key,required this.ticketId}) : super(key: key);

  @override
  State<TicketLogList> createState() => _TicketLogListState();
}

class _TicketLogListState extends State<TicketLogList> {

  TicketLogListModel? orticketLogListModel;
  TicketLogListModel? ticketLogListModel;
  bool isDataLoading = false;
  bool isExpanded = false;


  @override
  void initState() {
    super.initState();
    isDataLoading = true;
    getTicketData();
  }

  void getTicketData() async {
    orticketLogListModel = await Services().getTicketLogList(context, widget.ticketId);



    ticketLogListModel = orticketLogListModel;

    //print("ticketLogListModel:"+ ticketLogListModel!.logs!.length.toString()??'');

    setState(() {
      isDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Log List'),
      ),
      body: isDataLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

               Text('Status: ${ticketLogListModel?.firstLogCmpltDescription ?? ''}',
               textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Target Date',style: TextStyle(fontWeight: FontWeight.bold)),

                    Text(ticketLogListModel?.dueDateTime ?? '',style: TextStyle(decoration: TextDecoration.underline)),
                  ],
                ),

                hSpacer(12),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Raised by',style: TextStyle(fontWeight: FontWeight.bold)),

                    Text(ticketLogListModel?.ownerName ?? '',style: TextStyle(decoration: TextDecoration.underline)),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact Person',style: TextStyle(fontWeight: FontWeight.bold)),

                    Text(ticketLogListModel?.followed?.name ?? '',style: TextStyle(decoration: TextDecoration.underline)),
                  ],
                ),
                /**
                 * create listview for followed.handles
                 */
                hSpacer(12),

                /**
                 * Create text with icon on right
                 * to open escalated to dialog to show the list of handles
                 */
                InkWell(
                  onTap: (){
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor('#063553'),width: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Escalation',style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                        Icon(isExpanded?Icons.arrow_upward:Icons.arrow_downward),
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: isExpanded,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColorScheme.highTextColor,width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[

                        Text('Escalate to',style:
                        TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: ticketLogListModel?.followed?.handles?.length??0,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(ticketLogListModel?.followed?.handles?[index].name ?? ''),
                                subtitle: Text(ticketLogListModel?.followed?.handles?[index].mobile ?? ''),
                              );
                            },
                          ),
                        ),
                      ]
                    ),
                  ),
                ),



                hSpacer(12),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                       shrinkWrap: true,
                      itemCount: ticketLogListModel?.logs?.length??0,
                      itemBuilder: (context, index) {

                        Log? log = ticketLogListModel?.logs?[index];

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child:
                            ListTile(
                              title: Text(log?.clientDescription ?? ''),
                              subtitle: Text(log?.createdByuser?.name ?? '' + ' on' + (log?.createdAt ?? '')),
                            ),
                        );
                      },
                    ),
                ),
              ],
            ),
          ),
    );
  }
}
