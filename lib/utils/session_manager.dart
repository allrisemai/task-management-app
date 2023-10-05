import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class SessionManager extends StatefulWidget {
  final Widget child;
  final StreamController streamController;
  final Duration duration;
  final BuildContext context;

  const SessionManager(
      {Key? key,
      required this.child,
      required this.streamController,
      required this.duration,
      required this.context})
      : super(key: key);

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager>
    with WidgetsBindingObserver {
  Timer? _sessionTimer;

  //by using this function start the session timer
  void _startSessionTimer() {
    _sessionTimer = Timer(widget.duration, () {
      screenLock(
          context: context,
          correctString: '123456',
          canCancel: false,
          onUnlocked: () {
            _startSession();

            Navigator.of(context).pop();
          },
          onOpened: cancelTimer);
    });
  }

  // by using this close the session timer
  void cancelTimer() {
    if (_sessionTimer != null) {
      _sessionTimer!.cancel();
    }
  }

  //by using this able to start session
  void _startSession() {
    cancelTimer();
    _startSessionTimer();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.streamController.stream.listen((event) {
      if (event != null && event['timer'] as bool) {
        _startSession();
      } else {
        cancelTimer();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      _startSession();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _startSession();
      },
      onHover: (_) {
        _startSession();
      },
      child: Listener(
          onPointerSignal: (_) {
            _startSession();
          },
          onPointerDown: (_) {
            _startSession();
          },
          onPointerPanZoomStart: (_) {
            _startSession();
          },
          onPointerPanZoomEnd: (_) {
            _startSession();
          },
          child: RawKeyboardListener(
              autofocus: true,
              focusNode: FocusNode(),
              onKey: (event) {
                _startSession();
              },
              child: widget.child)),
    );
  }
}
