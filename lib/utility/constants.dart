import 'package:flexiares/utility/functions.dart';
import 'package:flutter/material.dart';

const String endpoint = 'https://flexiares.in/';
const String _baseDomain = 'https://flexiares.in';
const String _apiRoot = '$_baseDomain/api';
const String _v1 = 'v1';
const String loginUrl = '$_apiRoot/central-login';
const String forgotPasswordUrl = '$_apiRoot/$_v1/forgot-password';

String buildPath(String path) => path;

final String roomListUrl = buildPath('/settings/rooms');
final String bookingListUrl = buildPath('/booking');
final String visitorUrl = buildPath('/visitors');
final String visitorVerifyUrl = buildPath('/verify-visitor');
final String ticketCreateUrl = buildPath('/manage-ticket/add-ticket');
final String ticketListUrl = buildPath('/manage-ticket');
final String locationListUrl = buildPath('/locations');

const String appName = 'Flexiares';

HexColor _hex(String code) => HexColor(code);

final viewBg = _hex('#f8f8f8');
final lblValue = _hex('#222222');
final themeColor = _hex('#ad1a7f');

final colorAccent = _hex('#ff2068');
final colorPrimaryDark = _hex('#6d0094');
final colorAccentSecondary = _hex('#6d0094');

Color _fromRGB(int r, int g, int b) => Color.fromRGBO(r, g, b, 1);

const Color greyColor = Color(0xffaeaeae);
const Color greyColor2 = Color(0xffE8E8E8);

final themeColor2 = _fromRGB(32, 49, 82);
final primaryColor = _fromRGB(32, 49, 82);
final primaryColorLight = _fromRGB(42, 74, 130);

final iconColor = Color(0xff7490ff);
const Color lightBlack = Color(0xFF525151);
