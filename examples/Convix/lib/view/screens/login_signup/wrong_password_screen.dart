import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/model/mock/mock_model.dart';
import 'package:covermeapp/repository/mock_repository/mock_repository.dart';
import 'package:flutter/material.dart';

class WrongPassword extends StatefulWidget {
  const WrongPassword({Key? key}) : super(key: key);

  @override
  _WrongPasswordState createState() => _WrongPasswordState();
}

class _WrongPasswordState extends State<WrongPassword> {
  Mok? mockData;


  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Hidder",
          style: titleTextStyle,
        ),
      ),
      body: mockData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                  child: ListTile(
                    leading: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cGray.withOpacity(0.5),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                    title: Text(
                      "${mockData!.name}",
                      style: normalTextStyle.copyWith(fontSize: 18),
                    ),
                    subtitle: Text(
                      "how are you!",
                      style: normalTextStyle,
                    ),
                  ),
                );
              }),
    );
  }

  void getData() async {
    Mok mok = await MockRepository.mockRepo(context: context);
    setState(() {
      mockData = mok;
    });
  }
}
