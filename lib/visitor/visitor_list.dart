import 'package:flexiares/model/visitor_list_model.dart';
import 'package:flutter/material.dart';
import '../services/api_network.dart';
import '../ui_values/controls_ui.dart';
import '../ui_values/space_ui.dart';
import '../utility/constants.dart';
import '../utility/functions.dart';
import 'add_visitior.dart';

class VisitorList extends StatefulWidget {

  @override
  State<VisitorList> createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {

  List<VisitorListModel>? visitors;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getVisitors();
  }

  void getVisitors() async{


    setState((){
      visitors?.clear();
      isLoading = true;

    });
    visitors = await Services().getAllVisitorInfo(context);


    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //
      //     FloatingActionButton(
      //       /**
      //        * circular button to create a new ticket
      //        */
      //       backgroundColor: HexColor('#e2b616'),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(32.0),
      //       ),
      //       onPressed: () {
      //
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) =>
      //                     AddVisitor())).then((value){
      //                 if(value==true) getVisitors();
      //         });
      //
      //       },
      //       child: const Icon(Icons.add, color: Colors.white,),
      //     ),
      //     hSpacer(8),
      //     FloatingActionButton(
      //       /**
      //        * circular button to create a new ticket
      //        */
      //       backgroundColor: HexColor('#e2b616'),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(32.0),
      //       ),
      //       onPressed: () async{
      //
      //             openQRCodeScan();
      //
      //         },
      //       child: const Icon(Icons.qr_code, color: Colors.white,),
      //     ),
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                      ),


                      Expanded(child: Center(child: Text('Visitors',style: TextStyle(fontSize: 24.0,color: Colors.white),))),


                      FloatingActionButton(
                        /**
                         * circular button to create a new ticket
                         */
                        heroTag: 'addBtn',
                        mini: true,
                        backgroundColor: HexColor('#e2b616'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        onPressed: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddVisitor())).then((value){
                            if(value==true) getVisitors();
                          });

                        },
                        child: const Icon(Icons.add, color: Colors.white,),
                      ),
                      vSpacer(2),
                      FloatingActionButton(
                        heroTag: 'qrBtn',
                        mini: true,
                        /**
                         * circular button to create a new ticket
                         */
                        backgroundColor: HexColor('#e2b616'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        onPressed: () async{

                          openQRCodeScan();

                        },
                        child: const Icon(Icons.qr_code, color: Colors.white,),
                      ),
                    ]
                ),
              ),
            ),

            hSpacer(12),
            isLoading ? const Center(child: CircularProgressIndicator(),) :
            visitors?.isEmpty??true ? const Center(child: Text('No visitors found',style: TextStyle(fontSize: 16.0),)) :
            Expanded(
              child: ListView.builder(
                itemCount: visitors?.length??0,
                itemBuilder: (context, index) {
                  return visitorTile(visitor: visitors?[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget visitorTile({VisitorListModel? visitor}){
    return Card(
      elevation: 0.2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: primaryColorLight),
        borderRadius: BorderRadius.circular(12.0),

      ),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        visitor?.name ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          decoration: TextDecoration.none,
                          color: themeColor2,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      hSpacer(8),
                      Text(
                        visitor?.checkindate ?? '',
                        style: TextStyle(
                          color: HexColor('#28427A'),
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      hSpacer(8),
                      Text(
                        visitor?.checkintime ?? '',
                        style: TextStyle(
                          color: HexColor('#28427A'),
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                    ],
                  ),
                ),

                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                        visible: visitor?.status_string?.toLowerCase()=='arrived'?false:true,
                        child: InkWell(
                          onTap: () async{
                            // bool? isCancelled = await Services().cancelVisitor(context, visitor?.id??'');
                            // if(isCancelled??false){
                            //   Navigator.pop(context);
                            // }
                            callVisitorDelete(context,visitor?.id.toString()??'');
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: HexColor('#28427A'),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),
                        )),

                    hSpacer(16),
      Text(
        visitor?.status_string ?? '',
        style: TextStyle(
          color: (visitor?.status_string?.toLowerCase() == 'arrived')
              ? Colors.green
              : Colors.red, // Or any fallback color
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      ),


                  ],
                ),),

              ],
            ),
            hSpacer(4),

          ],
        ),
      ),

    );
  }


  void openQRCodeScan() async{
    String qrCodeValue=await qrdata();
    String tokenValue = qrCodeValue.split('token=')[1];

    if(qrCodeValue.isNotEmpty){
        bool isData= await Services().verifyVisitor(context, tokenValue);
        if(isData){
          visitors?.clear();
          getVisitors();
        }
        else{
          showToast(context, 'Failed to verify visitor');
        }
    }
    else{
      //showToast(context, 'QR code not found');
    }
  }

  void callVisitorDelete(BuildContext context,String visitorId) async{

    bool isCancelled = await Services().deleteVisitor(context, visitorId);

    if(isCancelled){
      showToast(context, 'Visitor cancelled successfully');
      visitors?.clear();
      getVisitors();
    }
    else{
      showToast(context, 'Failed to cancel visitor');
    }


  }

  void showToast(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }
}


