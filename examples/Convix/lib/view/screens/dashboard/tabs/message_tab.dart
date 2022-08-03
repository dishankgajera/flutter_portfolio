import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/model/friend_request_model.dart';
import 'package:covermeapp/repository/freind_request_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../chat_screen/chat_screen.dart';
import 'floating_action_button.dart';

class MessageTab extends StatefulWidget {

  final Function(int)? callBackFunction;
  MessageTab({this.callBackFunction});

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  FriendRequestModel? friendRequestModel;

    @override
    void initState() {
      getAllFriends();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: cOffWhite,
        extendBody: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: cMain,
          centerTitle: true,
          title: Text("Messages", style: titleTextStyle),
        ),
        body: friendRequestModel == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : friendRequestModel!.data!.length == 0
            ? Center(
          child: Text(
            "No any chat found !",
            style: normalTextStyle,
          ),
        )
            : ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 2,
              color: Colors.blueGrey,
            );
          },
          itemCount: friendRequestModel!.data!.length,
          itemBuilder: (context, index) {
            return friendRequestModel!.data![index].userId!.email ==
                User.email
                ? Container(
              color: cWhite,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(
                            entertainerId: User.profileId,
                            personId: friendRequestModel!
                                .data![index].requestedId!.profileId!
                                .toString(), //same vala ni id
                            senderName: friendRequestModel!
                                .data![index]
                                .requestedId!
                                .email!, //same vala nu email
                            reciverName: friendRequestModel!
                                .data![index]
                                .userId!
                                .email!, //aapdu email
                          ),
                    ),
                  ).whenComplete(() => getAllFriends());
                },
                contentPadding:
                EdgeInsets.only(right: 8, left: 8),
                leading: Container(
                  width: 50,
                  height: 100,
                  decoration: BoxDecoration(
                      color: cMain.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.assignment_ind,
                    size: 33,
                    color: cMain,
                  ),
                ),
                title: Text(
                    friendRequestModel!
                        .data![index].requestedId!.email!,
                    style: normalTextStyle),
                subtitle: Row(
                  children: [
                    Text(
                        friendRequestModel!.data![index].lastMsg!
                            .length !=
                            0
                            ? friendRequestModel!.data![index]
                            .lastMsg!.last.message
                            .toString()
                            : "",
                        style:
                        grayTextStyle.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            )
                : Container(
              color: cWhite,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(
                            entertainerId: User.profileId,
                            personId: friendRequestModel!
                                .data![index].userId!.profileId!
                                .toString(), //aapdi email
                            senderName: friendRequestModel!
                                .data![index]
                                .userId!
                                .email!, //samevalu nu email
                            reciverName: friendRequestModel!
                                .data![index]
                                .requestedId!
                                .email!, //aapdu email
                          ),
                    ),
                  ).whenComplete(() => getAllFriends());
                },
                contentPadding:
                EdgeInsets.only(right: 8, left: 8),
                leading: Container(
                  width: 50,
                  height: 100,
                  decoration: BoxDecoration(
                      color: cMain.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.assignment_ind,
                    size: 33,
                    color: cMain,
                  ),
                ),
                title: Text(
                    friendRequestModel!
                        .data![index].userId!.email!,
                    style: normalTextStyle),
                subtitle: Text(
                    friendRequestModel!
                        .data![index].lastMsg!.length !=
                        0
                        ? friendRequestModel!
                        .data![index].lastMsg!.last.message
                        .toString()
                        : "",
                    style: grayTextStyle.copyWith(fontSize: 14)),
              ),
            );
          },
        ),
        floatingActionButton: ExpandableFab(
          distance: 70.0,
          children: [
            ActionButton(
              onPressed: () async {
                SharedPreferences _pref = await SharedPreferences.getInstance();
                var profileId = _pref.getString(PrefString.profileId);
                await Share.share("Hidder ID : $profileId",
                    subject: "Hidder ID : $profileId",
                );
              },
              icon: Icon(Icons.share),
            ),
            ActionButton(
              onPressed: () {
                // _showAction(context, 1);
                widget.callBackFunction!(1);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      );
    }

    void getAllFriends() async {
      FriendRequestModel data = await FriendRequestRepository
          .getAllFriendRequest(
          context: context, status: "1");
      if (data.status == 200) {
        friendRequestModel = data;
        WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
      } else {
        print("SOMETHING WENT WRONG TO GET DATA OF ACCEPTED REQUEST.");
      }
    }
  }
