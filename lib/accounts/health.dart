class HeySocksHealth {
  String? _route;
  int _failures = 0;
  bool _notified = false;

  void reset() {
    _route = null;
    _failures = 0;
    _notified = false;
  }

  bool record(String route, int delay, {bool manual = false}) {
    if (_route != route || delay > 0) {
      reset();
      _route = route;
    }
    if (delay >= 0) return false;
    _failures++;
    if (_notified || (!manual && _failures < 2)) return false;
    _notified = true;
    return true;
  }
}
