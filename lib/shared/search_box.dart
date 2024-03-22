// ignore_for_file: prefer_const_constructors, unused_element, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

Widget searchBox(TextEditingController _cityName) {
  return Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  autocorrect: false,
                  controller: _cityName,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintText: "Search city",
                      hintStyle: TextStyle(color: Colors.grey)
                    )
                  ),
                ),
              );
              
}