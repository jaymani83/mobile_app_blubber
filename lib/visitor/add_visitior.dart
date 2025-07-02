import 'package:flexiares/utility/constants.dart';
import 'package:flutter/material.dart';

import '../services/api_network.dart';
import '../ui_values/controls_ui.dart';
import '../ui_values/space_ui.dart';
import '../utility/color_scheme.dart';
import '../utility/functions.dart';


class AddVisitor extends StatefulWidget {
  @override
  State<AddVisitor> createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor> {

  /**
   * Name,Mobile, Email, Date, Time
   */
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white70,
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
                              Navigator.pop(context,false);
                            },
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                          ),


                          Visibility(
                              visible: true,
                              child: Expanded(child: Center(child: Text('Add Visitor',style: TextStyle(fontSize: 24.0,color: Colors.white),)))),


                        ]
                    ),
                  ),
                ),

                hSpacer(12),
                /**
                 * set allset image and text
                 */

                addVisitorForm(),

              ],
            ),
          ),
        ),
      )
    );
  }

  Widget addVisitorForm(){

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextFormField(
              controller: usernameController,
              obscureText: false,
              textAlign: TextAlign.start,
              validator: (value) => validateField(value, 'Name'),
              keyboardType: TextInputType.text,
              maxLength: 50,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                prefixIcon: Icon(Icons.person),
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: 'Name',
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.white70,
              ),
            ),
            hSpacer(),
            TextFormField(
              controller: mobileController,
              obscureText: false,
              textAlign: TextAlign.start,
              validator: (value) => validateMobileField(value, 'Mobile'),
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                prefixIcon: Icon(Icons.phone),
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: 'Mobile',
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.white70,
              ),
            ),
            hSpacer(),
            TextFormField(
              controller: emailController,
              obscureText: false,
              textAlign: TextAlign.start,
              validator: (value) => validateField(value, 'Email'),
              keyboardType: TextInputType.emailAddress,
              maxLength: 50,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                prefixIcon: Icon(Icons.email),
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: 'Email',
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.white70,
              ),
            ),

            hSpacer(),


          TextFormField(
            controller: dateController,
            readOnly: true,
            obscureText: false,textAlign: TextAlign.start,
            validator:(value) => validateField(value, 'Date'),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                prefixIcon: Icon(Icons.date_range),
                //labelText: text,
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: 'Date',
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.white70),

            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2036),
              ).then((value) {

                String selDate= value?.day.toString()??'';
                if(selDate.length==1){
                  selDate = '0$selDate';
                }

                String selMonth= value?.month.toString()??'';
                if(selMonth.length==1){
                  selMonth = '0$selMonth';
                }


                setState(() {
                  dateController.text = '$selDate-$selMonth-${value?.year}';
                });
              });
            },
          ),

            hSpacer(),


            TextFormField(
              controller: timeController,
              readOnly: true,
              obscureText: false,textAlign: TextAlign.start,
              validator:(value) => validateField(value, 'Time'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.access_time),
                  //labelText: text,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  hintText: 'Time',
                  contentPadding: const EdgeInsets.all(16.0),
                  fillColor: Colors.white70),

              onTap: () {
                /**
                 * show time picker dialog with 24 hour format
                 */
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  setState(() {

                    String hourValue = value?.hour.toString()??'';
                    if(hourValue.length==1){
                      hourValue = '0$hourValue';
                    }

                    String minuteValue = value?.minute.toString()??'';
                    if(minuteValue.length==1){
                      minuteValue = '0$minuteValue';
                    }


                    timeController.text = '$hourValue:$minuteValue';
                  });
                });
              },
            ),
            hSpacer(),


            isLoading?const Center(child: CircularProgressIndicator()):
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  validateData();
                }
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



          ],
        ),
      ),
    );

  }

  void validateData() async{



    if (usernameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        emailController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Must enter all fields'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (!isEmailValid(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (mobileController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid mobile number'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }


    setState(() {
      isLoading = true;
    });

    /**
     * call postAddVisitor api
     */
    bool status = await  Services().postAddVisitor(context, uname: usernameController.text, mobile: mobileController.text, email: emailController.text, selDate: dateController.text, selTime: timeController.text);

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Visitor added successfully'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add visitor'),
          duration: Duration(seconds: 3),
        ),
      );
    }


    setState(() {
      isLoading = false;
    });

  }

  bool isEmailValid(String text) {

    if(text.isEmpty){
      return false;
    }
    if(text.contains('@') && text.contains('.')){
      return true;
    }

    return false;
  }

}
