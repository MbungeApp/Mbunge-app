// import 'package:flutter/foundation.dart';
// import 'package:mqtt_client/mqtt_client.dart' as client;

// enum MqttCurrentConnectionState {
//   IDLE,
//   CONNECTING,
//   CONNECTED,
//   DISCONNECTED,
//   ERROR_WHEN_CONNECTING
// }
// enum MqttSubscriptionState { IDLE, SUBSCRIBED }

// class MQTTCON {
//   VoidCallback onConnectedCallback;
//   Function(String) onMessageReceivedCallback;
//   int myPhoneNumber;

//   static final MQTTCON _singleton = MQTTCON._internal();

//   String mqtthost = "test.mosquitto.org";
//   String mqttusername = "";
//   String mqttpassword = "";
//   int mqttport = 1883;
//   client.MqttClient mqttClient;
//   MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
//   MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

//   factory MQTTCON(
//       {VoidCallback voidCallback, int phoneNumber, messageReceivedCallback}) {
//     _singleton.onConnectedCallback = voidCallback;
//     _singleton.onMessageReceivedCallback = messageReceivedCallback;
//     _singleton.myPhoneNumber = phoneNumber;
//     return _singleton;
//   }

//   MQTTCON._internal();

//   init() {
//     mqttClient = client.MqttClient.withPort(
//       'tcp://test.mosquitto.org',
//       'test123-client2',
//       1883,
//     );
//     mqttClient.logging(on: false);
//     mqttClient.keepAlivePeriod = 20;
//     mqttClient.onDisconnected = _onDisconnected;
//     mqttClient.onConnected = _onConnected;
//     mqttClient.onSubscribed = _onSubscribed;
//   }

//   void _onSubscribed(String topic) {
//     print('MQTTClientWrapper::Subscription confirmed for topic $topic');
//     subscriptionState = MqttSubscriptionState.SUBSCRIBED;
//   }

//   void _onDisconnected() {
//     print(
//       'MQTTClientWrapper::OnDisconnected client callback - Client disconnection',
//     );
//     if (mqttClient.connectionStatus.returnCode ==
//         client.MqttConnectReturnCode.noneSpecified) {
//       print(
//         'MQTTClientWrapper::OnDisconnected callback is noneSpecified, this is correct',
//       );
//     }
//     connectionState = MqttCurrentConnectionState.DISCONNECTED;
//   }

//   void _onConnected() {
//     connectionState = MqttCurrentConnectionState.CONNECTED;
//     print(
//       'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful',
//     );
//     onConnectedCallback();
//   }

//   // publish message
//   void _publishMessage({String message, String topicName}) {
//     final client.MqttClientPayloadBuilder builder =
//         client.MqttClientPayloadBuilder();
//     builder.addString(message);

//     print('MQTTClientWrapper::Publishing message $message to topic $topicName');
//     mqttClient.publishMessage(
//         topicName, client.MqttQos.exactlyOnce, builder.payload);
//   }

//   // subscribe message
//   void _subscribeToTopic(String topicName) {
//     print('MQTTClientWrapper::Subscribing to the $topicName topic');
//     mqttClient.subscribe(topicName, client.MqttQos.atMostOnce);
//     mqttClient.updates
//         .listen((List<client.MqttReceivedMessage<client.MqttMessage>> c) {
//       final client.MqttPublishMessage recMess = c[0].payload;
//       final String newMessageJson =
//           client.MqttPublishPayload.bytesToStringAsString(
//         recMess.payload.message,
//       );
//       print("MQTTClientWrapper::GOT A NEW MESSAGE $newMessageJson");
//       if (newMessageJson != null) {
//         onMessageReceivedCallback(newMessageJson);
//       }
//     });
//   }
// }
