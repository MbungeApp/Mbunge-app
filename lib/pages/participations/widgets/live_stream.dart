import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/cubit/webinarstatus_cubit.dart';
import 'package:mbunge/models/webinar_status.dart';
import 'package:mbunge/repository/webinar_repository.dart';
import 'dart:io' as io;
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock/wakelock.dart';

class LiveStreamPage extends StatefulWidget {
  final String id;

  const LiveStreamPage({Key key, this.id}) : super(key: key);
  @override
  _LiveStreamPageState createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  WebinarstatusCubit webinarstatusCubit;
  static const String app_id = "c8449ba570c04c52b6a20e01c5e7f6ea";
  static const String token = null;
  RtcEngine _client;
  int userUUid;
  List<int> remoteUid = [];
  ValueNotifier<String> message = ValueNotifier("Checking stream status");

  String get channelid => widget.id;

  bool isAgoraJoined = false;

  @override
  void initState() {
    message.addListener(() {
      setState(() {});
    });
    webinarstatusCubit = WebinarstatusCubit(WebinarRepository());
    webinarstatusCubit.checkStatus(channelid);

    super.initState();
  }

  joinStream() async {
    await _initAgoraRtcEngine();
    if (io.Platform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }
    message.value = "";
    await joinChannel2(channelid);
  }

  @override
  void dispose() {
    message?.dispose();
    leaveChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => webinarstatusCubit,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text("Livestream: ${remoteUid.length ?? 0}"),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                leaveChannel();
              },
            ),
          ],
        ),
        body: BlocListener(
          cubit: webinarstatusCubit,
          listener: (context, state) {
            if (state is WebinarstatusInitial) {
              message.value = "Checking stream status";
            }
            if (state is WebinarstatusError) {
              message.value = "An error occurred";
            }
            if (state is WebinarstatusLoaded) {
              WebinarStatus webinarStatus = state.webinarStatus;
              if (webinarStatus.data.channelExist) {
                joinStream();
              } else {
                message.value = "Stream is not live";
              }
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: message.value == ""
                    ? remoteUid.length != 0
                        ? RtcRemoteView.SurfaceView(
                            uid: remoteUid[0],
                            channelId: channelid,
                          )
                        : Text("Connecting...")
                    : SizedBox.shrink(),
              ),
              message.value == ""
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.center,
                      child: Text(message.value),
                    ),
              Align(
                alignment: Alignment.topRight,
                child: Text("${remoteUid.length} audience"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initAgoraRtcEngine() async {
    _client = await RtcEngine.create(app_id);
    await _client.enableVideo();
    await _client.enableAudio();
    await _client.setChannelProfile(ChannelProfile.LiveBroadcasting);
    addAgoraEventHandlers();
  }

  /// Add agora event handlers
  addAgoraEventHandlers() {
    _client.setEventHandler(RtcEngineEventHandler(error: (code) {
      print("**********************************");
      print('onError: $code');
      print("**********************************");
    }, joinChannelSuccess: (channel, uid, elapsed) async {
      print("**********************************");
      print('onJoinChannel: $channel, uid: $uid');
      print("**********************************");
      setState(() {
        isAgoraJoined = true;
      });
      await Wakelock.enable();
    }, leaveChannel: (stats) async {
      print("**********************************");
      print('onLeaveChannel');
      print("**********************************");
      setState(() {
        remoteUid = [];
      });
      await Wakelock.disable();
    }, userJoined: (uid, elapsed) async {
      print("**********************************");
      print('userJoined: $uid');
      print("**********************************");
      setState(() {
        // userUUid = uid;
        remoteUid.add(uid);
      });
    }, userOffline: (uid, elapsed) async {
      print("**********************************");
      print('userOffline: $uid');
      print("**********************************");
      setState(() {
        remoteUid.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      print('firstRemoteVideo: $uid ${width}x $height');
    }));
  }

  Future<void> joinChannel2(String channelId) async {
    try {
      await _client.setClientRole(ClientRole.Audience);
      await _client?.joinChannel(token, channelId, null, 0);
    } catch (e) {
      print("************************************");
      print('join channel exception:\n$e');
      print("************************************");
    }
  }

  Future<void> leaveChannel() async {
    await _client?.leaveChannel();
    // useruuidController?.close();
  }
}
