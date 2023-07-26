// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:fcm/checking.dart';
import 'package:fcm/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TextEditingController controller;


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();


    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       payload: 'full_screen_notification',
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channelDescription: channel.description,
      //           color: Colors.blue,
      //           importance: Importance.max,
      //           priority: Priority.high,
      //           fullScreenIntent: true,
      //           playSound: true,
      //           icon: '@mipmap/ic_launcher',
      //         ),
      //       ));
      // }
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const checking(),),);
    });



  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Fcm Demo'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[


              FutureBuilder(
              future: FirebaseMessaging.instance.getToken(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return InkWell(
                  onTap: (){
                    Clipboard.setData(ClipboardData(text: snapshot.data.toString() ));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('token copied'),
                    ));
                  },
                  child: Text(snapshot.data.toString()),
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error_outline);
              } else {
                return const CircularProgressIndicator();
              }
            }),




                const SizedBox(
                  height: 10,
                ),


                TextFormField(
                  controller: controller,

                ),

                const SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                    onPressed: () async {

                      await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode({
                          'to': controller.text ,
                          'priority':'high',
                          'notification':{
                            'title':'12 send',
                            'body':'12 send'
                          }
                        }),
                        headers: {
                          'Content-Type':'application/json; charset=UTF-8',
                          'Authorization':'key='
                        }
                      );

                    },
                    child: const Text('notification',style: TextStyle(fontWeight: FontWeight.bold),)
                ),

                const SizedBox(
                  height: 10,
                ),


              ],
            ),
        ),
      ),
    );
  }
}
