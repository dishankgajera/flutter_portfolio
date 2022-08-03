import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/data.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/model/create_request_model.dart';
import 'package:covermeapp/model/find_by_profile_id_model.dart';
import 'package:covermeapp/repository/create_request_repository.dart';
import 'package:covermeapp/repository/find_by_profile_id_repository.dart';
import 'package:covermeapp/view/widgets/common_widget/Toast/toast_message.dart';
import 'package:covermeapp/view/widgets/common_widget/dialogbox/common_dialogbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHidderFriends extends StatefulWidget {
  const AddHidderFriends({Key? key}) : super(key: key);

  @override
  _AddHidderFriendsState createState() => _AddHidderFriendsState();
}

class _AddHidderFriendsState extends State<AddHidderFriends> {
  FindByProfileIdModel? fModel;
  TextEditingController profileId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cOffWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cMain,
        elevation: 0,
        title: Text(
          "Add Hidder User",
          style: titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: cWhite,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: profileId,
                    onChanged: (v) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Hidder ID",
                        contentPadding: EdgeInsets.only(left: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: profileId.text == ""
                        ? null
                        : () {
                            if (profileId.text.length == 0) {
                              showToastMessage(
                                  context: context,
                                  message: "Enter Hidder Id !");
                            } else if (profileId.text.length != 8) {
                              showToastMessage(
                                  context: context,
                                  message: "Enter valid Hidder Id !");
                            } else if (profileId.text.length != 0 &&
                                profileId.text.length == 8) {
                              findByprofileId();
                            }
                          },
                    child: Container(
                      child: Icon(
                        CupertinoIcons.plus_circle_fill,
                        color: profileId.text.length < 8
                            ? cGray
                            : cGreen.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fModel == null
              ? Container()
              : ListTile(
                  contentPadding: EdgeInsets.only(right: 8, left: 8),
                  leading: Container(
                    width: 50,
                    height: 100,
                    decoration: BoxDecoration(
                        color: cMain.withOpacity(0.5), shape: BoxShape.circle),
                    child: Icon(
                      Icons.assignment_ind,
                      size: 33,
                      color: cMain,
                    ),
                  ),
                  title: Text(fModel!.data!.email!,
                      style: normalTextStyle.copyWith(fontSize: 14)),
                  subtitle: Text(
                      "Profile ID :- ${fModel!.data!.profileId!.toString()} (${fModel!.data!.status! == "0" ? "Nutral" : fModel!.data!.status! == "1" ? "Acceted" : fModel!.data!.status! == "2" ? "Rejected" : fModel!.data!.status! == "3" ? "Pending for varification" : "Other"} )",
                      style: grayTextStyle.copyWith(fontSize: 14)),
                  trailing: fModel!.data!.status! != "0"
                      ? null
                      : ElevatedButton(
                          child: Text("Request",
                              style: titleTextStyle.copyWith(fontSize: 14)),
                          style: ElevatedButton.styleFrom(
                            primary: cGreen.withOpacity(0.7),
                          ),
                          onPressed: () {
                            if (fModel!.data!.status! == "0") {
                              createRequest(requestId: fModel!.data!.id);
                            }
                          },
                        ),
                ),
        ],
      ),
    );
  }

  void findByprofileId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(User.id);
    FindByProfileIdModel findByProfileIdModel =
        await FindByProfileIdRepo.findByProfileId(
            context: context, profileId: profileId.text, userId: userId);
    if (findByProfileIdModel.status == 200) {
      setState(() {
        fModel = findByProfileIdModel;
      });
      showToastMessage(context: context, message: findByProfileIdModel.message);
    } else {
      showToastMessage(context: context, message: findByProfileIdModel.message);
      showDialog(
        context: context,
        builder: (context) => CommonDialog(
          titleText: "info",
          subTitle: "Please enter a valid Hidder ID!",
          buttonText1: "ok",
          button1OnPress: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  void createRequest({String? requestId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(User.id);
    CreateRequestModel createRequestModel =
        await CreateRequestRepo.createRequest(
            context: context, requestedId: requestId, userId: userId);
    if (createRequestModel.status == 200) {
      setState(() {
        fModel = null;
      });
      showToastMessage(context: context, message: createRequestModel.message);
    } else {
      showToastMessage(context: context, message: createRequestModel.message);
      showDialog(
        context: context,
        builder: (context) => CommonDialog(
          titleText: "info",
          subTitle: "Please enter a valid Hidder ID!",
          buttonText1: "ok",
          button1OnPress: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }
}
