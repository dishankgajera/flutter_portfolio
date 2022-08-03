class DefaultImage {}

class PrefString {
  static const String token = "token";
  static const String userId = "userId";
  static const String email = 'email';
  static const String password = 'password';
  static const String profileId = 'profileId';
}

class DefaultApiString {
  static const String mockApi = "";
  static const String endPoint = "";
  static const String SignUp = "user/signup";
  static const String login = "user/login";
  static const String ShowUser = "user/showuser";
  static const String findByprofileId = "user/findByprofileId";
  static const String createRequest = "buddies";
  static const String friendRequest = "buddies/getbuddiesByStatus?status=";
  static const String changeRequestStatus = "buddies/";

  //chat
  static const String socketServerUrl = "";
  static const String initializeChat = 'chat/initiatechat';

  static const String sendMessage = "new-message";

  static const String initializeChatRoom = "join";
  static const String getMessageHistory = "history";

  //AGORA VIDEO CALL
  static const String agoraTokenGenerate = 'user/getAccessToken?channelName=';

  //API CONSTANT
  static const String transportsHeader = 'transports';
  static const String webSocketOption = 'websocket';
  static const String pollingOption = 'polling';

  //APP CONSTANT
  static const String mobileConnectionStatus = "ConnectivityResult.mobile";
  static const String wifiConnectionStatus = "ConnectivityResult.wifi";
  static const String agoraAppId = "69d844c84b304d4ab1f47a910e4857f4";

  //ARGS CONSTANT
  //static const String connectId = "id";
  static const String resCallRequestModel = "resCallRequestModel";
  static const String resCallAcceptModel = "resCallAcceptModel";
  static const String isForOutGoing = "isForOutGoing";
  static const String channelKey = "channelName";
  static const String channelTokenKey = "token";

  //FILE CONSTANT
  static const String icUserPlaceholder =
      'assets/images/ic_user_placeholder.svg';
  static const String icTimer = 'assets/images/ic_timer.svg';

  //DEFAULT EVENTS
  static const String eventConnect = "join-profile" /*?? "connect"*/;

  static const String eventDisconnect = "disconnect";
  static const String eventConnectTimeout = "connect_timeout";
  static const String onSocketError = "onSocketError";

  //VIDEO CALL EVENTS
  static const String connectCall = "connectCall";
  static const String onCallRequest = "onCallRequest";
  static const String acceptCall = "acceptCall";
  static const String onAcceptCall = "onAcceptCall";
  static const String rejectCall = "rejectCall";
  static const String onRejectCall = "onRejectCall";
  static bool isVideoCall = false;
}
