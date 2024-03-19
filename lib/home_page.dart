// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:weatherapp/shared/gradient_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GradientScaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              // Row of texts
              child: ListTile(
                title: Text(
                  "March 19 2024",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                subtitle: Text(
                  "My Day",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                trailing: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/pexels-alotrobo-5053222.jpg'),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GlassContainer(
                      height: 200,
                      width: 180,
                      blur: 5,
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3)
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Location",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.location_on_outlined, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                    ),

                    SizedBox(height: 20),

                    GlassContainer(
                      height: 160,
                      width: 180,
                      blur: 5,
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3)
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Weather",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.wb_cloudy_outlined, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                    ),

                    SizedBox(height: 20),

                    GlassContainer(
                      height: 300,
                      width: 180,
                      blur: 5,
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3)
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Sunrise",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.wb_twilight_rounded, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                    ),

                  ],
                ),

                // Second column of boxes inside the row
                Column(
                  children: [
                    GlassContainer(
                      height: 300,
                      width: 180,
                      blur: 5,
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3)
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Temp",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.water_drop_outlined, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                    ),

                    SizedBox(height: 20),

                   GlassContainer(
                      height: 200,
                      width: 180,
                      blur: 5,
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3)
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Feels like",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.hot_tub, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                    ),

                    SizedBox(height: 20),

                    GlassContainer(
                      height: 160,
                      width: 180,
                      blur: 5,
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(35),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.blue.withOpacity(0.3)
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Date",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.date_range_outlined, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}