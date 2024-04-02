import 'package:flutter/material.dart';
import '../Utils/brand_color.dart';
AppBar topAppBar(title){
  return AppBar(
        elevation: 0.1,
        backgroundColor: primaryColor,
        leading: const Icon(Icons.menu),
        title: SizedBox(
          height: 50,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                ),
              ),
            ),
        ),
        actions: const <Widget>[Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.search),
        )],
        centerTitle: true,
        flexibleSpace: Container(
        decoration: const BoxDecoration(
        color: primaryColor)),
      );
}