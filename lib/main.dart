import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'Control Pad Example',
      home: GameControllerPage(),
    );
  }
}

class GameControllerPage extends StatefulWidget {
  final WebSocketChannel channel = IOWebSocketChannel.connect('wss://echo.websocket.org');
  @override
  _GameControllerPageState createState() => _GameControllerPageState();
}

class _GameControllerPageState extends State<GameControllerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Control Pad Example'),
        ),
        body: Center(
          child: Row(
            children: [
              Container(
                child: JoystickView(),
              ),
              Container(
                child: PadButtonsView(),
              ),
              Flexible(child: TextField(
                decoration: InputDecoration(
                  hintText: 'Test du Text field',
                ),
              )),
              Expanded(
                  child: StreamBuilder(
                    stream: widget.channel.stream,
                    builder: (context, snapshot) {
                      return Text(snapshot.hasData ? '${snapshot.data}' : '');
                    },
              ))
            ],
          ),

        )

    );
  }
}
