import 'package:flutter/material.dart';
import '../services/timer_service.dart';
import '../theme/app_theme.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final TimerService _timer = TimerService();

  @override
  void initState() {
    super.initState();
    _timer.addListener(_onTimerTick);
    _timer.init();
  }

  @override
  void dispose() {
    _timer.removeListener(_onTimerTick);
    super.dispose();
  }

  void _onTimerTick() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final studyMinutesToday = _timer.totalStudySecondsToday ~/ 60;
    final studyHoursToday = (studyMinutesToday / 60).toStringAsFixed(1);

    Color activeColor;
    switch (_timer.mode) {
      case TimerMode.study:
        activeColor = AppColors.cyan;
        break;
      case TimerMode.practice:
        activeColor = AppColors.purpleViolet;
        break;
      case TimerMode.shortBreak:
        activeColor = AppColors.emeraldGreen;
        break;
      case TimerMode.longBreak:
        activeColor = AppColors.amberOrange;
        break;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'مؤقت التركيز وجلسات المذاكرة والراحة',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'دورات ذكية (50 دقيقة دراسة + 10 دقائق استراحة) لضمان أعلى استيعاب دون إجهاد',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // Timer Mode Selector Chips
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildModeButton('مذاكرة مركزة (50د)', TimerMode.study, AppColors.cyan),
                  const SizedBox(width: 10),
                  _buildModeButton('تطبيق وكود (60د)', TimerMode.practice, AppColors.purpleViolet),
                  const SizedBox(width: 10),
                  _buildModeButton('راحة وتمدد (10د)', TimerMode.shortBreak, AppColors.emeraldGreen),
                  const SizedBox(width: 10),
                  _buildModeButton('أكل وصلاة (20د)', TimerMode.longBreak, AppColors.amberOrange),
                ],
              ),
              const SizedBox(height: 24),

              // Center Circular Timer
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.bgSurface,
                          boxShadow: [
                            BoxShadow(
                              color: activeColor.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                          border: Border.all(
                            color: activeColor.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: CircularProgressIndicator(
                                value: _timer.progress,
                                strokeWidth: 10,
                                backgroundColor: AppColors.bgSurfaceLight,
                                valueColor: AlwaysStoppedAnimation<Color>(activeColor),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _timer.formattedTime,
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _timer.modeTitleArabic,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: activeColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Control Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              if (_timer.isRunning) {
                                _timer.pause();
                              } else {
                                _timer.start();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _timer.isRunning ? AppColors.amberOrange : activeColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            icon: Icon(_timer.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 24),
                            label: Text(
                              _timer.isRunning ? 'إيقاف مؤقت' : 'بدء الجلسة',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 14),
                          OutlinedButton.icon(
                            onPressed: _timer.reset,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              side: const BorderSide(color: AppColors.borderLight),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            icon: const Icon(Icons.refresh_rounded, size: 20),
                            label: const Text('إعادة ضبط', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Stats & Healthy Tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      icon: Icons.timer_rounded,
                      color: AppColors.cyan,
                      title: 'إجمالي دراسة اليوم',
                      value: '$studyHoursToday ساعة ($studyMinutesToday دقيقة)',
                    ),
                    _buildStatItem(
                      icon: Icons.task_alt_rounded,
                      color: AppColors.emeraldGreen,
                      title: 'الجلسات المكتملة',
                      value: '${_timer.completedSessionsToday} جلسات',
                    ),
                    _buildStatItem(
                      icon: Icons.water_drop_rounded,
                      color: AppColors.blueFlutter,
                      title: 'تذكير أثناء الراحة',
                      value: 'اشرب ماء وتمدد 5 دقائق',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(String title, TimerMode mode, Color color) {
    final isSelected = _timer.mode == mode;
    return ElevatedButton(
      onPressed: () => _timer.setMode(mode),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color.withOpacity(0.2) : AppColors.bgSurface,
        foregroundColor: isSelected ? color : AppColors.textSecondary,
        elevation: 0,
        side: BorderSide(color: isSelected ? color : AppColors.borderLight),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
