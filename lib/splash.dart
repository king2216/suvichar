import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String image = "https://images.unsplash.com/photo-1631943406801-ba6ccfa4f682?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1587&q=80";

  bool isLoad = false;
  List<String> quotes = [
    "The purpose of our lives is to be happy.",
    "Life is what happens when you're busy making other plans.",
    "Get busy living or get busy dying.",
    "You only live once, but if you do it right, once is enough.",
    "Life is what happens when you're busy making other plans.",
    "Get busy living or get busy dying.",
    "You only live once, but if you do it right, once is enough."
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {

            getPhoto();
          },
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  image,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black26,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Center(
                  child: Text(
                    quotes[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800,
                        fontSize: 30),
                  ),
                ),
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/dots-menu.png",
                height: 25,
                color: Colors.white,
              ),
              Text(
                "Quotes",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              CircleAvatar(
                child: Image.asset("assets/images/profile.png"),
                maxRadius: 15,
              )
            ],
          ),
        ),
      ],
    ));
  }

  Future getPhoto() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.unsplash.com/photos/random?client_id=IaC9oFLLrn-zKRjKVPKkbnA1wI9K4vo3gw9iGTlFlhA&per_page=1'));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        // result = responseData['results'];

        image = responseData['urls']['small'].toString();
        isLoad = false;
        setState(() {});
      } else {}
    } catch (e) {
      debugPrint("Error$e");
    }
  }
}
