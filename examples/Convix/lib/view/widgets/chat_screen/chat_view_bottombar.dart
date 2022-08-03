import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/view/widgets/chat_screen/chatController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget chatViewBottomBar(
    {Function? onSend,
      Function? onTap,
      BuildContext? context,
      TextEditingController? controller,
      bool isMicShow = false,
      Function? onChanged}) {
  ChatController chatController=Get.put(ChatController());
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
          },
          child: Icon(
            Icons.add,
            color: cMain,
            size: 30,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: onChanged as void Function(String)?,
              controller: controller,
              showCursor: true,
              decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(),
                filled: true,

                hintText: "Type here",
                hintStyle: TextStyle(color: cMain),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            )
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Obx(()=>InkWell(
          onTap: onSend as void Function()?,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: cMain,
                borderRadius: BorderRadius.circular(30)),
            child:chatController.isisMicShow.value == false
                ? Icon(
              Icons.mic_none_outlined,
              color: Colors.white,
            )
                : Icon(Icons.send, color: Colors.white),
          ),
        ),)
      ],
    ),
  );
}