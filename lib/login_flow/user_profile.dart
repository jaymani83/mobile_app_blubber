import 'package:flexiares/login_flow/login_page.dart';
import 'package:flexiares/ui_values/controls_ui.dart';
import 'package:flexiares/utility/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/login_model.dart';
import '../provider/login_provider.dart';
import '../utility/functions.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _ProfileStateHandler();
}

class _ProfileStateHandler extends State<UserProfile> {
  LoginModel? _data;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final providerInstance = context.read<LoginProvider>();
      _data = providerInstance.getLoginData();
      setState(() {});
    });
  }

  PreferredSizeWidget _buildTopBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(72),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
        child: Container(
          padding: const EdgeInsets.only(top: 22),
          color: HexColor('#011630'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _iconBtn(context, Icons.arrow_back, true),
              const Text('Profile', style: TextStyle(color: Colors.white, fontSize: 18)),
              _iconBtn(context, Icons.arrow_back, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBtn(BuildContext context, IconData icon, bool visible) {
    return IconButton(
      onPressed: visible ? () => Navigator.pop(context) : null,
      icon: Icon(icon, color: visible ? Colors.white : Colors.transparent),
    );
  }

  Widget _layeredImageSection() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/profile_bg_jpg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/profile_pic.jpg'),
          ),
        ),
      ],
    );
  }

  Widget _infoLine(String label, String value, CommonWidget widgetBuilder) {
    return widgetBuilder.customListTile(label, value);
  }

  List<Widget> _informationWidgets(CommonWidget builder) {
    final items = <Map<String, String?>>[
      {'Company Name': _data?.name},
      {'Phone Number': _data?.mobile},
      {'Email Address': _data?.email},
    ];

    return [
      _textSection(_data?.name?.toUpperCase() ?? '', 18),
      _textSection(_data?.role ?? '', 16),
      const Visibility(
        visible: false,
        child: ListTile(title: Text('ID Proof'), trailing: Icon(Icons.arrow_forward)),
      ),
      for (var item in items)
        _infoLine(item.keys.first, item.values.first ?? '', builder),
    ];
  }

  Widget _textSection(String text, double fontSize) {
    return Center(child: Text(text, style: TextStyle(fontSize: fontSize)));
  }

  Widget _exitControl(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          context.read<LoginProvider>().logout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),
                (_) => false,
          );
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final builder = CommonWidget();

    return Scaffold(
      appBar: customAppBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _layeredImageSection(),
                  ..._informationWidgets(builder),
                ],
              ),
            ),
            _exitControl(context),
          ],
        ),
      ),
    );
  }
}
