import 'dart:async';
import 'dart:ui';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/default_data.dart';
import 'package:covermeapp/controller/agora/call_controller.dart';
import 'package:covermeapp/controller/chat_controller/chat_controller.dart';
import 'package:covermeapp/view/widgets/agora_video_call/leave_dialog.dart';
import 'package:covermeapp/view/widgets/agora_video_call/timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

class VideoCallingScreen extends StatefulWidget {
  final String? channelName;
  final String? token;
  final String? otherId;
  final bool? isForVideoCall;

  VideoCallingScreen({this.channelName, this.token, this.isForVideoCall, this.otherId});

  @override
  _VideoCallingScreenState createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  bool _joined = false;
  int? _remoteUid;
  bool _switch = false;
  final _infoStrings = <String>[];

  bool _isFront = false;
  bool _reConnectingRemoteView = false;
  final GlobalKey<TimerViewState> _timerKey = GlobalKey();
  bool _mutedAudio = false;
  bool _mutedVideo = false;
  final chatController = Get.put(ChatController());
  final callController = Get.put(CallController());

  @override
  void initState() {
    super.initState();
    print("CALL TYPE ________ ${widget.isForVideoCall}");
    Wakelock.enable(); // Turn on wakelock feature till call is running
    initializeCalling();
  }

  @override
  void dispose() {
    print(
        "IN DISPOSE START---------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    callController.engine!.stopAllEffects();
    callController.engine!.stopAudioRecording();
    callController.engine!.leaveChannel();
    callController.engine!.destroy();
    Wakelock.disable(); // Turn off wakelock feature after call end
    print(
        "IN DISPOSE END ---------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    super.dispose();
  }

  //Initialize All The Setup For Agora Video Call
  Future<void> initializeCalling() async {
    if (DefaultApiString.agoraAppId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    Future.delayed(Duration.zero, () async {
      await FlutterRingtonePlayer.stop();
      await _initAgoraRtcEngine();
      _addAgoraEventHandlers();
      var configuration = VideoEncoderConfiguration();
      configuration.dimensions = VideoDimensions(height: 1920, width: 1080);
      configuration.orientationMode = VideoOutputOrientationMode.Adaptative;
      print("BEFORE CONNECT :----- ${widget.token} \n '${widget.channelName!}'");
      await callController.engine!.setVideoEncoderConfiguration(configuration);
      await callController.engine!.joinChannel(widget.token, widget.channelName!, null, 0);
    });
  }

  //Initialize Agora RTC Engine
  Future<void> _initAgoraRtcEngine() async {
    callController.engine = await RtcEngine.create(DefaultApiString.agoraAppId);
    await callController.engine!.enableVideo();
  }

  //Switch Camera
  _onToggleCamera() {
    callController.engine?.switchCamera().then((value) {
      setState(() {
        _isFront = !_isFront;
      });
    }).catchError((err) {});
  }

  //Audio On / Off
  void _onToggleMuteAudio() {
    setState(() {
      _mutedAudio = !_mutedAudio;
    });
    callController.engine!.muteLocalAudioStream(_mutedAudio);
  }

  //Video On / Off
  void _onToggleMuteVideo() {
    setState(() {
      _mutedVideo = !_mutedVideo;
    });
    callController.engine!.muteLocalVideoStream(_mutedVideo);
  }

  //Agora Events Handler To Implement Ui/UX Based On Your Requirements
  void _addAgoraEventHandlers() {
    callController.engine!.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'onError:$code ${code.index}';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          _joined = true;
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _remoteUid = uid;
        });
      },
      userOffline: (uid, elapsed) async {
        if (elapsed == UserOfflineReason.Dropped) {
          Wakelock.disable();
        } else {
          setState(() {
            final info = 'userOffline: $uid';
            _infoStrings.add(info);
            _remoteUid = null;
            _timerKey.currentState?.cancelTimer();
          });
        }
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'firstRemoteVideo: $uid ${width}x $height';
          _infoStrings.add(info);
        });
      },
      connectionStateChanged: (type, reason) async {
        if (type == ConnectionStateType.Connected) {
          setState(() {
            _reConnectingRemoteView = false;
          });
        } else if (type == ConnectionStateType.Reconnecting) {
          setState(() {
            _reConnectingRemoteView = true;
          });
        }
      },
      remoteVideoStats: (remoteVideoStats) {
        if (remoteVideoStats.receivedBitrate == 0) {
          setState(() {
            _reConnectingRemoteView = true;
          });
        } else {
          setState(() {
            _reConnectingRemoteView = false;
          });
        }
      },
    ));
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed(
          context: context,
        );
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: widget.isForVideoCall!
              ? Stack(
                  children: [
                    Center(
                      child: _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                    ),
                    SafeArea(child: _timerView()),
                    _cameraView(),
                    Container(padding: EdgeInsets.symmetric(vertical: 20), child: _bottomPortionWidget(context)),
                    Container(padding: EdgeInsets.symmetric(vertical: 20), child: _cancelCallView(context: context))
                  ],
                )
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Icon(
                        Icons.person,
                        size: 200,
                        color: cMain,
                      ),
                      _timerView(),
                      Spacer(),
                      _cancelCallView(context: context),
                      Spacer(),
                    ],
                  ),
                )),
    );
  }

  //Get This Alert Dialog When User Press On Back Button
  Future<bool?> _onBackPressed({
    @required BuildContext? context,
  }) async {
    showCallLeaveDialog(context!, "END CALL", "END CALL NOW", "END CALL CANCEL", () {
      _onCallEnd(
        context: context,
      );
    });
    return false;
  }

  // Generate local preview
  Widget _renderLocalPreview() {
    if (_joined) {
      return rtc_local_view.SurfaceView();
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "WAITING FOR JOINING CALL....",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  // Generate remote preview
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return Stack(
        children: [
          rtc_remote_view.SurfaceView(
            uid: _remoteUid!,
          ),
          _reConnectingRemoteView
              ? Container(
                  color: Colors.black.withAlpha(200),
                  child: Center(
                      child: Text(
                    "RECONNECTING......",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )))
              : SizedBox(),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "WAITING FOR JOINING CALL....",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  //Timer Ui
  Widget _timerView() => TimerView(
        updateTimerStatus: () {},
      );

  //Local Camera View
  Widget _cameraView() => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        alignment: Alignment.bottomRight,
        child: FractionallySizedBox(
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.topRight,
            color: Colors.black,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _switch = !_switch;
                });
              },
              child: Center(
                child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
              ),
            ),
          ),
        ),
      );

  Widget _bottomPortionWidget(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RawMaterialButton(
              onPressed: _onToggleCamera,
              child: Icon(
                _isFront ? Icons.camera_front : Icons.camera_rear,
                color: Colors.white,
                size: 30,
              ),
              shape: CircleBorder(),
              // elevation: 2.0,
              fillColor: _isFront ? Colors.blue : Colors.transparent,
              padding: const EdgeInsets.all(10),
            ),
            RawMaterialButton(
              onPressed: _onToggleMuteVideo,
              child: Icon(
                _mutedVideo ? Icons.videocam_off : Icons.videocam,
                color: Colors.white,
                size: 30,
              ),
              shape: CircleBorder(),
              // elevation: 2.0,
              fillColor: _mutedVideo ? Colors.blue : Colors.transparent,
              padding: const EdgeInsets.all(10),
            ),
            RawMaterialButton(
              onPressed: _onToggleMuteAudio,
              child: Icon(
                _mutedAudio ? Icons.mic_off : Icons.mic,
                color: Colors.white,
                size: 30,
              ),
              shape: CircleBorder(),
              // elevation: 2.0,
              fillColor: _mutedAudio ? Colors.blue : Colors.transparent,
              padding: const EdgeInsets.all(10),
            ),
          ],
        ),
      );

  //Cancel Button Ui/Ux
  Widget _cancelCallView({
    @required BuildContext? context,
  }) =>
      Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            _onCallEnd(context: context);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.call_end,
              size: 30,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
      );

  //Use This Method To End Call
  void _onCallEnd({
    @required BuildContext? context,
  }) async {
    Wakelock.disable();
    callController.rejectCall(context, channelName: widget.channelName, token: widget.token, otherId: widget.otherId);
  }
}
