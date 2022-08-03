import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/model/friend_request/friend_request_model.dart';
import 'package:covermeapp/model/friend_request_model.dart';
import 'package:covermeapp/repository/freind_request_repository.dart';
import 'package:covermeapp/view/widgets/common_widget/Toast/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestsTab extends StatefulWidget {
  const RequestsTab({Key? key}) : super(key: key);

  @override
  _RequestsTabState createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  FriendRequestModel? friendRequestModel;

  String? email;

  @override
  void initState() {
    getMyEmail();
    getAllFriendRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: cMain,
        title: Text(
          'Your Requests',
          style: titleTextStyle,
        ),
      ),
      body: friendRequestModel == null || friendRequestModel!.status == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : friendRequestModel!.data!.length == 0
              ? Center(
                  child: Text(
                    "No any request found !",
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
                  itemBuilder: (BuildContext context, int index) {
                    return friendRequestModel!.data![index].userId!.email.toString() == email.toString()
                        ? Container()
                        : ListTile(
                            onTap: () {},
                            contentPadding: EdgeInsets.only(right: 8, left: 8),
                            leading: Container(
                              width: 50,
                              height: 100,
                              decoration: BoxDecoration(color: cMain.withOpacity(0.5), shape: BoxShape.circle),
                              child: Icon(
                                Icons.assignment_ind,
                                size: 33,
                                color: cMain,
                              ),
                            ),
                            title: Text(friendRequestModel!.data![index].userId!.email.toString(), style: normalTextStyle),
                            subtitle: Row(
                              children: [
                                ElevatedButton(
                                  child: Text("Accept", style: titleTextStyle.copyWith(fontSize: 14, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    primary: cGreen.withOpacity(0.60),
                                  ),
                                  onPressed: () {
                                    acceptAndRejectRequest(
                                        status: "1", requestId: friendRequestModel!.data![index].id.toString());
                                  },
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  child: Text("Reject", style: titleTextStyle.copyWith(fontSize: 14)),
                                  style: ElevatedButton.styleFrom(
                                    primary: cRed.withOpacity(0.60),
                                  ),
                                  onPressed: () {
                                    acceptAndRejectRequest(
                                        status: "2", requestId: friendRequestModel!.data![index].id.toString());
                                  },
                                ),
                                // SizedBox(width: 75),
                              ],
                            ),
                          );
                  }),
    );
  }

  void getMyEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences.getString(PrefString.email);
  }

  void getAllFriendRequest() async {
    FriendRequestModel data = await FriendRequestRepository.getAllFriendRequest(context: context, status: "3");
    if (data.status == 200) {
      friendRequestModel = data;
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
  }

  void acceptAndRejectRequest({
    @required String? status,
    @required String? requestId,
  }) async {
    RequestAcceptRejectModel data =
        await FriendRequestRepository.changeFriendRequestStatus(context: context, status: status!, requestId: requestId!);
    if (data.status == 200) {
      showToastMessage(context: context, message: data.message);
      getAllFriendRequest();
    } else {
      showToastMessage(context: context, message: data.message);
      print("SOMETHING WENT WRONG ______>>>>>");
    }
  }
}
