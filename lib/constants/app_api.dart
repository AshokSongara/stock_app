class AppApi {
  // WebSocket URLs
  static const String webSocketUrl = 'wss://streamer.ysil.in/';

  // WebSocket Actions
  static const String subscribeAction = 'subscribe';
  static const String freeFeedType = 'freefeed';

  // Stock Symbols
  static const String niftySymbol = 'NSEIDX_26000';
  static const String sensexSymbol = 'BSEIDX_1';

  // WebSocket Messages
  static const String webSocketClosedMessage = 'WebSocket connection closed';
  static const String webSocketReconnectDelay = 'Reconnecting in 5 seconds...';

  // Reconnection
  static const int reconnectDelaySeconds = 5;
} 