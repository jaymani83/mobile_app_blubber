import 'dart:io';

import 'package:flexiares/ticket_flow/ticket_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_network.dart';
import '../ui_values/controls_ui.dart';
import '../utility/color_scheme.dart';
import '../utility/functions.dart';
import '../utility/navigate_page.dart';

class CreateTicket extends StatefulWidget {
  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  bool isLoading = false;
  TextEditingController concernController = TextEditingController();
  File? _image;
  final ImagePicker picker = ImagePicker();


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
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Raise a Ticket',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(children: [

                      TextField(
                        controller: concernController,
                        decoration: InputDecoration(
                          labelText: 'Please type your concern here...',
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      InkWell(
                        onTap: () {
                          /**
                           * ask user to open camera or gallery and select image
                           * and set the file path to filePath
                           */

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select Image'),
                                content: Text('Open Camera or Gallery'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      openGallery(context,camera: true);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Camera'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // open gallery
                                      openGallery(context,camera: false);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Gallery'),
                                  ),
                                ],
                              );
                            },
                          );


                        },
                        child: Container(
                          width: 250,

                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.attach_file,
                                  color: Colors.black,
                                ),
                              ),

                              Text(
                                'Attach image',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      _image != null
                          ? Center(
                            child: Container(
                              width: 84,

                              //padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              child: Column(
                                children: [

                                  /**
                                   * close icon
                                   */
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _image = null;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                                    child: Image.file(
                                        _image!,
                                        width: 75,
                                        height: 75,
                                      ),
                                  ),
                                  ],
                              ),
                            ),
                          )
                          : Container(),

                      SizedBox(
                        height: 20.0,
                      ),

                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : GestureDetector(
                        onTap: () {
                          validateData();
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: CustomColorScheme.btnColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                      ,
                      SizedBox(height: 6.0),
                    ]),
                  ),
                ],
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     goToPage(context, TicketList());
            //   },
            //   child: Text('Ticket Report',
            //       style: TextStyle(fontStyle: FontStyle.italic)),
            // ),
          ],
        ),
      ),
    );
  }


  void openGallery(BuildContext context,{bool camera=false}) async {
    // open gallery
    // set the file path to filePath

    final image = await ImagePicker().pickImage(source: camera?ImageSource.camera:ImageSource.gallery);

    final filePath = image!.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 88,
    );
    setState(() {
      if (result != null) {
        _image = File(result.path);

      } else {
        print('No image selected.');
      }
    });


  }

  void validateData() async {

    /**
     * validate concern
     */
    if (concernController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Must enter your concern'),
          duration: Duration(seconds: 3),
        ),
      );


      return;
    } else {

      setState(() {
        isLoading = true;
      });

      bool status =
          await Services().createTicket(concernController.text, _image, context);

      if (status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ticket created successfully'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context, 'success');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong.\nFailed to create ticket'),
            duration: Duration(seconds: 3),
          ),
        );
      }


      setState(() {
        isLoading = false;
      });
    }
  }
}
