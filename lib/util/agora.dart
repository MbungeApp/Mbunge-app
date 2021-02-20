// import 'dart:async';

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:wakelock/wakelock.dart';

// class AgoraClient {
//   // singleton
//   static final AgoraClient _agoraClient = AgoraClient._internal();
//   factory AgoraClient() {
//     return _agoraClient;
//   }
//   AgoraClient._internal();

//   static const String app_id = "c8449ba570c04c52b6a20e01c5e7f6ea";
//   static const String token = null;

//   RtcEngine _client;
//   bool isJoined = false;
//   StreamController<List<int>> remoteUid = StreamController.broadcast()..add([]);
//   StreamController<int> useruuidController = StreamController.broadcast();

//   Future<void> initialize() async {
//     await _initAgoraRtcEngine();
//     addAgoraEventHandlers();
//     await _client.enableWebSdkInteroperability(true);
//     await _client.setParameters(
//       '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''',
//     );
//     // VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
//     // configuration.dimensions = VideoDimensions(1920, 1080);
//     // await _client.setVideoEncoderConfiguration(configuration);
//   }

//   /// Create agora sdk instance and initialize
//   Future<void> _initAgoraRtcEngine() async {
//     _client = await RtcEngine.create(app_id);
//     await _client.enableVideo();
//     await _client.enableAudio();
//     await _client.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     addAgoraEventHandlers();
//   }

//   Future<void> dispose() async {
//     _client?.destroy();
//   }

//   /// Add agora event handlers
//   addAgoraEventHandlers() {
//     _client.setEventHandler(RtcEngineEventHandler(error: (code) {
//       print("**********************************");
//       print('onError: $code');
//       print("**********************************");
//     }, joinChannelSuccess: (channel, uid, elapsed) async {
//       print("**********************************");
//       print('onJoinChannel: $channel, uid: $uid');
//       print("**********************************");
//       isJoined = true;
//       useruuidController.add(uid);
//       await Wakelock.enable();
//     }, leaveChannel: (stats) async {
//       print("**********************************");
//       print('onLeaveChannel');
//       print("**********************************");
//       remoteUid.add([]);
//       await Wakelock.disable();
//     }, userJoined: (uid, elapsed) async {
//       print("**********************************");
//       print('userJoined: $uid');
//       print("**********************************");
//       useruuidController.add(uid);
//       List<int> _ids = await remoteUid.stream.last;
//       _ids.add(uid);
//       remoteUid.add(_ids);
//     }, userOffline: (uid, elapsed) async {
//       print("**********************************");
//       print('userOffline: $uid');
//       print("**********************************");
//       List<int> _ids = await remoteUid.stream.last;
//       _ids.remove(uid);
//       remoteUid.add(_ids);
//     }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
//       print('firstRemoteVideo: $uid ${width}x $height');
//     }));
//   }

//   Future<void> joinChannel(String channelId) async {
//     try {
//       await _client.setClientRole(ClientRole.Broadcaster);
//       await _client?.joinChannel(token, channelId, null, 0);
//     } catch (e) {
//       print("************************************");
//       print('join channel exception:\n$e');
//       print("************************************");
//     }
//   }

//   Future<void> joinChannel2(String channelId) async {
//     try {
//       await _client.setClientRole(ClientRole.Audience);
//       await _client?.joinChannel(token, channelId, null, 0);

//       isJoined = true;
//     } catch (e) {
//       print("************************************");
//       print('join channel exception:\n$e');
//       print("************************************");
//     }
//   }

//   Stream<int> getJoinedUser() {
//     Stream stream = useruuidController.stream;
//     return stream;
//   }

//   Stream<List<int>> getJoinedUsers() {
//     Stream stream = remoteUid.stream;
//     return stream;
//   }

//   Future<void> leaveChannel() async {
//     await _client?.leaveChannel();
//     // useruuidController?.close();
//   }
// }
