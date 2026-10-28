import 'dart:async';
import 'package:flutter/material.dart';
import '../services/prayer_service.dart';
import '../theme/app_theme.dart';

class PrayerBanner extends StatefulWidget {
  const PrayerBanner({super.key});

  @override
  State<PrayerBanner> createState() => _PrayerBannerState();
}

class _PrayerBannerState extends State<PrayerBanner> {
  Timer? _countdownTimer;
  Map<String, dynamic> _countdown = PrayerService.getNextPrayerCountdown();

  @override
  void initState() {
    super.initState();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _countdown = PrayerService.getNextPrayerCountdown();
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prayers = PrayerService.getDailyPrayerList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header row with Next prayer countdown and City selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.emeraldGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.mosque_rounded, color: AppColors.emeraldGreen, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'الصلاة القادمة: ',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            _countdown['prayerName'],
                            style: const TextStyle(
                              color: AppColors.emeraldGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'متبقي ${_countdown['formattedRemaining']}',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // City Preset Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.bgSurfaceLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CityPreset>(
                    value: PrayerService.selectedCity,
                    dropdownColor: AppColors.bgSurfaceLight,
                    icon: const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary, size: 20),
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
                    items: PrayerService.cities.map((city) {
                      return DropdownMenuItem<CityPreset>(
                        value: city,
                        child: Text(city.name),
                      );
                    }).toList(),
                    onChanged: (newCity) {
                      if (newCity != null) {
                        setState(() {
                          PrayerService.selectedCity = newCity;
                          _countdown = PrayerService.getNextPrayerCountdown();
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          // Horizontal list of prayers
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: prayers.map((p) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: p.isNext ? AppColors.emeraldGreen.withValues(alpha: 0.18) : AppColors.bgCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: p.isNext ? AppColors.emeraldGreen : AppColors.borderLight.withValues(alpha: 0.5),
                      width: p.isNext ? 1.5 : 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        p.icon,
                        size: 16,
                        color: p.isNext ? AppColors.emeraldGreen : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.nameArabic,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: p.isNext ? FontWeight.bold : FontWeight.normal,
                              color: p.isNext ? AppColors.emeraldGreen : AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            p.formattedTime,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: p.isNext ? AppColors.textPrimary : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
