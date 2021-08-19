import 'dart:async';
import 'package:agora_channel_realtimedb/agorafunc/call.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:agora_channel_realtimedb/agorafunc/call_helper.dart';
import 'package:agora_channel_realtimedb/agorafunc/call_taker.dart';


class ListviewPage extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListviewPage> {

  ClientRole? _role = ClientRole.Audience;

  String _displayText = 'Results go here';
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _uidStream;
  final uid = 'uid';

  // late DatabaseReference _uidRef;

  @override
  void initState() {
    //  final FirebaseDatabase database = FirebaseDatabase(app: this.app);
    //  _uidRef = database.reference().child('Uids');

    super.initState();
  //  _activateListeners();
  }
  //
  // void _activateListeners() {
  //   _uidStream = _database.child('Uids').onValue.listen((event) {
  //     final data = new Map<String, dynamic>.from(event.snapshot.value);
  //     final uid = UID.fromRTDB(data);
  //     //final String? uid = event.snapshot.value;
  //     setState(() {
  //       _displayText = 'Channel name : $uid';
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //  final ref = referenceDatabase.reference();
    return Scaffold(
        appBar: AppBar(
          title: Text('Channel List'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [

                  StreamBuilder(
                      stream: _database
                          .child('Uids')
                          .orderByKey()
                          //.child('uid')
                          .limitToLast(10)
                          .onValue,
                      builder: (context, snapshot) {
                        final tilesList = <ListTile>[];
                        if (snapshot.hasData) {
                          final Channels = Map<String, dynamic>.from(
                              (snapshot.data! as Event).snapshot.value);
                          Channels.forEach((key, value) {
                            final nextchannel =
                                Map<String, dynamic>.from(value);
                            final uidTile = ListTile(
                              leading: Icon(Icons.favorite),
                              title: Text(nextchannel['uid']),
                              onTap: () => {
                                Get.to(() => CallPage_helper(
                                  channelName: nextchannel['uid'],
                                  //role: _role,
                                ))
                              }
                            );
                            tilesList.add(uidTile);
                          });
                        }
                        return Expanded(child: ListView(children: tilesList));
                      })
                ],
              )),
        ));
  }
}
