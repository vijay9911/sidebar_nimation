import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sidebar_nimation/pages/home_page.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:sidebar_nimation/sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);


  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSideBarOpenedStreamController;

  late Stream<bool> isSideBarOpenedStream;
  late StreamSink<bool> isSideBarOpenedSink;
  final _animationDuration= const Duration(milliseconds: 500);
  @override
  void initState() {

    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSideBarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream= isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink= isSideBarOpenedStreamController.sink;
  }
  @override
  void dispose() {
    _animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }
  void onIconPressed(){
    final animationStatus= _animationController.status;
    final isAnimationCompleted= animationStatus==AnimationStatus.completed;
    if(isAnimationCompleted){
      isSideBarOpenedSink.add(false);
    _animationController.reverse();
    }
    else{
      isSideBarOpenedSink.add(true);
      _animationController.forward();
      
    }
  }
  @override
  Widget build(BuildContext context) {
    final ScreenWidth= MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync){
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0:-ScreenWidth,
          right: isSideBarOpenedAsync.data! ? 0: ScreenWidth-45,

          child: Row(
            children:<Widget>[
              Expanded(child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Color(0xFF262AAA),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100,),
                    ListTile(
                      title: Text("Vijay Gupta",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),

                      ),
                      subtitle: Text("vijaygupta1593@gmail.com",style: TextStyle(
                          color: Color(0xFF1BB5FD), fontSize: 14, fontWeight: FontWeight.w800),),
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                        ),
                        radius: 40,
                      ),
                    ),
                    Divider(
                      height: 70,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 35,
                      endIndent: 35,
                    ),
                    Item(icon: Icons.home, title: "Home", onTap: (){

                    }, ),
                    Item(icon: Icons.person, title: "My Account",onTap: (){

                    },  ),
                    Item(icon: Icons.shopping_bag, title: "My Order",onTap: (){


                    },  ),
                    Item(icon: Icons.card_giftcard, title: "Wish List",onTap: (){


                    },  ),
                    Divider(
                      height: 70,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 35,
                      endIndent: 35,
                    ),
                    Item(icon: Icons.settings, title: "Settings",onTap: (){


                    },  ),
                    Item(icon: Icons.exit_to_app, title: "LogOut",onTap: (){
                      

                    },  ),
                  ],
                ),

              ),
              ),

              Align(
                alignment: Alignment(0,-0.9),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },

    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint= Paint();
    paint.color= Colors.white;
    final width= size.width;
    final height = size.height;
    Path path= Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
