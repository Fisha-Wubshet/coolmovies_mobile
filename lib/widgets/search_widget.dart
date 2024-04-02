import 'package:flutter/material.dart';

import '../Utils/brand_color.dart';

Widget searchWidget(){
return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 70,
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 10),
                    child:  TextFormField(
                        textInputAction: TextInputAction.search,
                        cursorColor: const Color(0xff229546),
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                           
                            suffixIcon: InkWell(
                              onTap: (){
                              },
                              child:  Container(
                                width: 55,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      '|',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 35,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){ 
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 10, left: 5),
                                        child: Icon(
                                          Icons.search,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffDADADA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText:  ' Search movie ...',
                            hintStyle: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Inter',
                              color: Color(0xff8391A1),
                            ),
                            filled: true,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            fillColor: const Color(0xffF7F8F9),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffDADADA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffDADADA)),
                              borderRadius: BorderRadius.circular(10),
                            ))),
                  ),
                ),]));}