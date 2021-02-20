import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTclient {
  static final client = MqttServerClient('tcp://test.mosquitto.org', '');

  Future<void> initConnection() async {
    client.logging(on: true);
    client.port = 1883;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('lens_JXOZGyg7T0dLR96sy2rvQ3PBtsd')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    // client.connectionMessage = connMess;
    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }
  // TODO
  // 1. init
  // subscribe to topics

  subscribeTopic(String userId) {
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
      client.subscribe("topics/users/$userId", MqttQos.atLeastOnce);
    }
  }
  // unsubscribe
}
