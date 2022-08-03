import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageRecipient extends StatefulWidget {
  @override
  _MessageRecipientState createState() => _MessageRecipientState();
}

class _MessageRecipientState extends State<MessageRecipient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cOffWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cMain,
        elevation: 0,
        title: Text(
          "Message Recipient",
          style: titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              // margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: cGray),
                color: cWhite,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  prefixIcon: Icon(CupertinoIcons.search),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('CoverMe Friends', style: grayTextStyle),
            )
          ],
        ),
      ),
    );
  }
}
