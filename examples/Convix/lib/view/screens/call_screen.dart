import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  _CallState createState() => _CallState();
}

class _CallState extends State<Call> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cOffWhite,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: cMain,
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isSelect = !isSelect;
                  });
                },
                child: Container(
                  width: 100,
                  color: isSelect ? Colors.black12.withOpacity(0.1) : cWhite,
                  padding:  EdgeInsets.all(2),
                  child: Center(child: Text('All', style: isSelect ? titleTextStyle.copyWith(fontSize: 15) : blueTextStyle.copyWith(fontSize: 15))),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelect = !isSelect;
                  });
                },
                child: Container(
                  width: 100,
                  color: !isSelect ? Colors.black12.withOpacity(0.1) : cWhite,
                  padding:  EdgeInsets.all(2),
                  child: Center(child: Text('Missed', style: !isSelect ? titleTextStyle.copyWith(fontSize: 15) : blueTextStyle.copyWith(fontSize: 15))),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 150),
          Container(
            height: 70,
            // width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cMain,
            ),
            child: Icon(
              Icons.call,
              size: 48,
              color: cWhite,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Calls Yet',
                    style: normalTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Secure private call. Do not show on bill',
                    style: grayTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 6),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: cMain,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Text(
                    'Try Now',
                    style: titleTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: cMain,
        child: Icon(
          Icons.phone,
          color: cWhite,
          size: 30,
        ),
        onPressed: () async{

            if (await canLaunch("tel:+916352535216")) {
              await launch("tel:  +916352535216");
            } else {
              throw 'Could not launch 6352535216';
            }

        },
      ),
    );
  }
}
