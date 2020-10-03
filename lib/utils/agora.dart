// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:wakelock/wakelock.dart';

// class Agora {
//   final String channelName;
//   Agora({this.channelName});

//   static const String APP_ID = "";

//   Future<void> initialize() async {
//     await _initAgoraRtcEngine();
//     _addAgoraEventHandlers();
//     await AgoraRtcEngine.enableWebSdkInteroperability(true);
//     await AgoraRtcEngine.setParameters(
//       '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''',
//     );
//     await AgoraRtcEngine.joinChannel(null, channelName, null, 0);
//   }

//   /// Create agora sdk instance and initialize
//   Future<void> _initAgoraRtcEngine() async {
//     await AgoraRtcEngine.create(APP_ID);
//     await AgoraRtcEngine.enableVideo();
//   }

//   /// Add agora event handlers
//   void _addAgoraEventHandlers() {
//     AgoraRtcEngine.onJoinChannelSuccess = (
//       String channel,
//       int uid,
//       int elapsed,
//     ) async {
//       await Wakelock.enable();
//     };

//     AgoraRtcEngine.onLeaveChannel = () {
//       setState(() {
//         _users.clear();
//       });
//     };

//     AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
//       setState(() {
//         _users.add(uid);
//       });
//     };

//     AgoraRtcEngine.onUserOffline = (int uid, int reason) {
//       setState(() {
//         _users.remove(uid);
//       });
//     };
//   }
// }
