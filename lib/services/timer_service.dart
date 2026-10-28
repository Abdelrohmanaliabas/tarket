import 'dart:async';
import 'package:flutter/material.dart';
import 'storage_service.dart';

enum TimerMode {
  study, // المذاكرة المركزة (4 ساعات مجزأة)
  practice, // ساعة التطبيق العملي
  shortBreak, // راحة قصيرة (10 دقائق)
  longBreak, // راحة طويلة (20 دقيقة)
}

class TimerService extends ChangeNotifier {
  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;
  TimerService._internal();

  Timer? _ticker;
  TimerMode _mode = TimerMode.study;
  int _secondsRemaining = 50 * 60; // Default 50 minutes
  int _totalDurationSeconds = 50 * 60;
  bool _isRunning = false;
  int _completedSessionsToday = 0;
  int _totalStudySecondsToday = 0;

  TimerMode get mode => _mode;
  int get secondsRemaining => _secondsRemaining;
  int get totalDurationSeconds => _totalDurationSeconds;
  bool get isRunning => _isRunning;
  int get completedSessionsToday => _completedSessionsToday;
  int get totalStudySecondsToday => _totalStudySecondsToday;

  double get progress {
    if (_totalDurationSeconds == 0) return 0;
    return (_totalDurationSeconds - _secondsRemaining) / _totalDurationSeconds;
  }

  String get formattedTime {
    final m = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get modeTitleArabic {
    switch (_mode) {
      case TimerMode.study:
        return 'جلسة مذاكرة مركزة (50 دقيقة)';
      case TimerMode.practice:
        return 'جلسة تطبيق عملي وكود (60 دقيقة)';
      case TimerMode.shortBreak:
        return 'فترة استراحة وتنشيط (10 دقائق)';
      case TimerMode.longBreak:
        return 'استراحة طويلة وأكل (20 دقيقة)';
    }
  }

  void init() async {
    _totalStudySecondsToday = await StorageService.getStudySecondsToday();
    notifyListeners();
  }

  void setMode(TimerMode newMode) {
    _ticker?.cancel();
    _isRunning = false;
    _mode = newMode;
    switch (newMode) {
      case TimerMode.study:
        _totalDurationSeconds = 50 * 60;
        break;
      case TimerMode.practice:
        _totalDurationSeconds = 60 * 60;
        break;
      case TimerMode.shortBreak:
        _totalDurationSeconds = 10 * 60;
        break;
      case TimerMode.longBreak:
        _totalDurationSeconds = 20 * 60;
        break;
    }
    _secondsRemaining = _totalDurationSeconds;
    notifyListeners();
  }

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        if (_mode == TimerMode.study || _mode == TimerMode.practice) {
          _totalStudySecondsToday++;
          if (_totalStudySecondsToday % 60 == 0) {
            StorageService.addStudySecondsToday(60);
          }
        }
        notifyListeners();
      } else {
        _timerCompleted();
      }
    });
    notifyListeners();
  }

  void pause() {
    _ticker?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void reset() {
    _ticker?.cancel();
    _isRunning = false;
    _secondsRemaining = _totalDurationSeconds;
    notifyListeners();
  }

  void _timerCompleted() {
    _ticker?.cancel();
    _isRunning = false;

    if (_mode == TimerMode.study || _mode == TimerMode.practice) {
      _completedSessionsToday++;
      // Suggest break
      setMode(TimerMode.shortBreak);
    } else {
      // Suggest study
      setMode(TimerMode.study);
    }
    notifyListeners();
  }
}
