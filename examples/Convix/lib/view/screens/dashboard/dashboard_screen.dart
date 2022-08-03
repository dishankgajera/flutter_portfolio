import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/controller/agora/call_controller.dart';
import 'package:covermeapp/controller/chat_controller/chat_controller.dart';
import 'package:covermeapp/utils/agora/permission_utils.dart';
import 'package:covermeapp/view/screens/add_hidder_friends.dart';
import 'package:covermeapp/view/screens/dashboard/tabs/message_tab.dart';
import 'package:covermeapp/view/screens/dashboard/tabs/request_tab.dart';
import 'package:covermeapp/view/screens/more_screen.dart';
import 'package:covermeapp/view/screens/passoword/password_screen.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  int _index = 0;

  final chatController = Get.put(ChatController());
  final callController = Get.put(CallController());

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    setSocket();
    super.initState();
  }

  void setSocket() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    print("DASHBOARD PROFILE ID ::::: ${sharedPreference.getString(PrefString.profileId)}");
    PermissionUtils.requestPermission(context);
    callController.initialVideoCall(
      context,
      profileId: sharedPreference.getString(PrefString.profileId),
      inComingPersonName: "",
      outgoingPersonName: "",
    );
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("APP_STATE: $state");

    if (state == AppLifecycleState.resumed) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordScreen(),
        ),
      );
    } else if (state == AppLifecycleState.inactive) {

    } else if (state == AppLifecycleState.paused) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _index == 0
            ? MessageTab(
                callBackFunction: (v) {
                  setState(() {
                    _index = 1;
                  });
                },
              )
            : _index == 1
                ? AddHidderFriends()
                : _index == 2
                    ? RequestsTab()
                    : _index == 3
                        ? MoreScreen()
                        : Container(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          if (mounted) {
            setState(() {
              _index = i;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        // selectedLabelStyle: TextStyle(fontSize: 0),
        // unselectedLabelStyle: TextStyle(fontSize: 0),
        selectedItemColor: Color(0xFF007AFF),
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.message_outlined,
              color: Color(0xFF007AFF),
            ),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.add_box_outlined,
              color: Color(0xFF007AFF),
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.request_page_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.request_page_outlined,
              color: Color(0xFF007AFF),
            ),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_ind_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.assignment_ind_outlined,
              color: Color(0xFF007AFF),
            ),
            label: "More",
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    FlutterRingtonePlayer.stop();
    if (callController.engine != null) callController.engine!.leaveChannel();
    if (callController.engine != null) callController.engine!.destroy();
    if (chatController.chatSocket != null) chatController.chatSocket.dispose();
    if (chatController.chatSocket != null) chatController.chatSocket.disconnect();
    super.dispose();
  }
}
