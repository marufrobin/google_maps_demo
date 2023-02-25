import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketIOPage extends StatefulWidget {
  const SocketIOPage({Key? key}) : super(key: key);

  @override
  State<SocketIOPage> createState() => _SocketIOPageState();
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class _SocketIOPageState extends State<SocketIOPage> {
  StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
  void connectAndListen() {
    IO.Socket socket = IO.io(
        'https://clean-soil-rest-api-z8eug.ondigitalocean.app/',
        OptionBuilder().setTransports(['websocket']).build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('socketLogin', {"userId": "63e7d071d21b69022bc4fa75"});
      // socket.emit("startSendLocation":{});
    });
    socket.emit("sendLocation", {
      "adminId": "63e7a16d97538230a84f34be",
      "location": {"lat": "22.3366", "lng": "91.8200"},
    });
    //When an event recieved from server, data is added to the stream
    socket.on('event', (data) => streamSocket.addResponse);
    socket.on('loggedIn', (data) => print("logged In ${data["message"]}"));
    socket.on('startSendLocation',
        (data) => print("start sending location In $data"));
    socket.on('isTrackingLocationOn',
        (data) => print("isTrackingLocationOn location In $data"));
    socket.on(
        'stopSendLocation', (data) => print("stop sending location In $data"));
    socket.onDisconnect((_) => print('disconnect'));
  }
/*

  late IO.Socket socket;
  initSocket() {
    socket = IO.io(
        "https://clean-soil-rest-api-z8eug.ondigitalocean.app/",
        <String, dynamic>{
          'autoConnect': false,
          'transports': ['websocket'],
        });
    socket.connect();
    socket.onConnect((data) {
      print('Connection established $data');
    });
    socket.on("message", (data) => print('message print $data'));
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }
*/

  @override
  void initState() {
    connectAndListen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          connectAndListen();
        },
        child: Icon(Icons.navigation_sharp),
      ),
      appBar: AppBar(
        title: Text("Socket IO testing"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: streamSocket.getResponse,
          builder: (context, snapshot) {
            return Container(
              child: Text(
                "${snapshot.data}",
                style: TextStyle(fontSize: 26),
              ),
            );
          },
        ),
      ),
    );
  }
}
