import 'package:flexiares/login_flow/user_profile.dart';
import 'package:flexiares/model/location_page.dart';
import 'package:flexiares/room_booking/room_list_one.dart';
import 'package:flexiares/ticket_flow/create_ticket.dart';
import 'package:flexiares/ticket_flow/ticket_list.dart';
import 'package:flexiares/utility/functions.dart';
import 'package:flexiares/utility/common_widget.dart';
import 'package:flexiares/utility/navigate_page.dart';
import 'package:flexiares/visitor/add_visitior.dart';
import 'package:flexiares/visitor/visitor_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/login_model.dart';
import '../provider/login_provider.dart';
import '../ui_values/controls_ui.dart';
import '../ui_values/space_ui.dart';
import 'login_data_scope.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final List<String> imageUrls;
  LoginModel? loginModel;

  @override
  void initState() {
    super.initState();
    imageUrls = _getImageUrls();
    loginModel = Provider.of<LoginProvider>(context, listen: false).getLoginData();
  }

  List<String> _getImageUrls() => [
    'https://www.avanta.co.in/wp-content/themes/flexiares_new/images/image-outer3.jpg',
    'https://www.avanta.co.in/wp-content/themes/flexiares_new/images/image-outer1.jpg',
    'https://www.avanta.co.in/wp-content/themes/flexiares_new/images/image-outer5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return LoginDataScope(
      loginModel: loginModel,
      child: Scaffold(
        appBar: customAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              _topHeader(),
              const SizedBox(height: 24),
              _welcomeText(),
              const SizedBox(height: 20),
              _userNameText(context),
              const SizedBox(height: 20),
              const Spacer(),
              _buttonColumn(context),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavBar(context),
      ),
    );
  }

  Widget _topHeader() => ClipRRect(
    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12.0)),
    child: Container(height: 72.0, color: HexColor('#011630')),
  );

  Widget _welcomeText() => const Center(
    child: Text('Welcome',
        style: TextStyle(fontSize: 36.0, color: Colors.black)),
  );

  Widget _userNameText(BuildContext context) {
    final loginData = LoginDataScope.of(context);
    return Center(
      child: Text(
        loginModel?.name?.toUpperCase() ?? '',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buttonColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _navButton('Book a meeting room', () {
            final token = LoginDataScope.of(context)?.token;
            if (kDebugMode) debugPrint(token);
            goToPage(context, RoomListOne());
          }),
          const SizedBox(height: 12),
          _navButton('Raise a ticket', () => goToPage(context, TicketList())),
          const SizedBox(height: 12),
          _navButton('Visitor Information', () => goToPage(context, VisitorList())),
          const SizedBox(height: 12),
         /* _navButton('Manage Team', () {}),*/
        ],
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onTap) {
    return SizedBox(
      height: 42,
      width: MediaQuery.of(context).size.width * 5.85,
      child: ElevatedButton(
        style: CommonWidget().buttonStyle(),
        onPressed: onTap,
        child: Text(label,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) => ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
    child: Container(
      color: Colors.white,
      height: 98.0,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _iconNav(context, Icons.star, 'Profile', () => goToPage(context, UserProfile())),
            _iconNav(context, Icons.meeting_room, 'Meeting Room', () => goToPage(context, RoomListOne())),
            _iconNav(context, Icons.home, 'Home', () =>goToPage(context, DashboardPage()), iconColor: Colors.blueGrey),
            _iconNav(context, Icons.call, 'Contact', () => goToPage(context, LocationsPage())),
          ],
        ),
      ),
    ),
  );

  Widget _iconNav(BuildContext context, IconData icon, String label, VoidCallback onTap,
      {Color iconColor = Colors.black}) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: iconColor), onPressed: onTap),
        Text(label),
      ],
    );
  }
}

