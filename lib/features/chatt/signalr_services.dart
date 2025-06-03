import 'dart:developer';

import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  late HubConnection _hubConnection;
  Future<void> initConnection(String hubUrl) async {
    try {
      _hubConnection = HubConnectionBuilder().withUrl(hubUrl).build();

      // عند نجاح الاتصال، احفظ الـ Connection ID
      _hubConnection.onclose(({error}) => log("Connection Closed"));

      await _hubConnection.start();
      log("Connection started");

      // الحصول على Connection ID بعد بدء الاتصال
      final connectionId = await _hubConnection.invoke("GetConnectionId");
      log("Connection ID: $connectionId");
    } catch (e) {
      log("Connection error: $e");
    }
  }

  void onReceiveMessage(Function(List<Object?>?) handler) {
    _hubConnection.on("ReceiveMessage", handler);
  }

  Future<void> sendMessage(String user, String message) async {
    try {
      // الحصول على Connection ID بشكل صحيح
      final connectionId =
          await _hubConnection.invoke("GetConnectionId") as String;

      // إرسال الرسالة مع Connection ID
      await _hubConnection.invoke("SendMessage",
          args: [user as Object, message as Object, connectionId as Object]);
      log("Message sent: $message from $user with ID: $connectionId");
    } catch (e) {
      log("Error sending message: $e");
    }
  }

  Future<void> stopConnection() async {
    await _hubConnection.stop();
  }
}
