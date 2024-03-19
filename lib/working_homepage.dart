// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:weatherapp/shared/gradient_scaffold.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      )..forward();

      _offsetAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: Offset(0.0, 1.0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: SafeArea(
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
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}