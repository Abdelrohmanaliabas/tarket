import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CityPreset {
  final String name;
  final double latitude;
  final double longitude;
  final CalculationMethod method;

  const CityPreset({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.method,
  });
}

class PrayerInfo {
  final String nameArabic;
  final DateTime time;
  final IconData icon;
  final bool isNext;

  PrayerInfo({
    required this.nameArabic,
    required this.time,
    required this.icon,
    this.isNext = false,
  });

  String get formattedTime {
    return DateFormat('hh:mm a').format(time);
  }
}

class PrayerService {
  static final List<CityPreset> cities = [
    const CityPreset(
      name: 'القاهرة، مصر',
      latitude: 30.0444,
      longitude: 31.2357,
      method: CalculationMethod.egyptian,
    ),
    const CityPreset(
      name: 'الإسكندرية، مصر',
      latitude: 31.2001,
      longitude: 29.9187,
      method: CalculationMethod.egyptian,
    ),
    const CityPreset(
      name: 'الرياض، السعودية',
      latitude: 24.7136,
      longitude: 46.6753,
      method: CalculationMethod.umm_al_qura,
    ),
    const CityPreset(
      name: 'مكة المكرمة، السعودية',
      latitude: 21.3891,
      longitude: 39.8579,
      method: CalculationMethod.umm_al_qura,
    ),
    const CityPreset(
      name: 'دبي، الإمارات',
      latitude: 25.2048,
      longitude: 55.2708,
      method: CalculationMethod.dubai,
    ),
  ];

  static CityPreset selectedCity = cities[0];

  static PrayerTimes getPrayerTimes([DateTime? date]) {
    final targetDate = date ?? DateTime.now();
    final coordinates = Coordinates(selectedCity.latitude, selectedCity.longitude);
    final params = selectedCity.method.getParameters();
    params.madhab = Madhab.shafi;
    return PrayerTimes(
      coordinates,
      DateComponents.from(targetDate),
      params,
    );
  }

  static List<PrayerInfo> getDailyPrayerList([DateTime? date]) {
    final pt = getPrayerTimes(date);
    final nextPrayer = pt.nextPrayer();

    return [
      PrayerInfo(
        nameArabic: 'الفجر',
        time: pt.fajr,
        icon: Icons.brightness_3_rounded,
        isNext: nextPrayer == Prayer.fajr,
      ),
      PrayerInfo(
        nameArabic: 'الشروق',
        time: pt.sunrise,
        icon: Icons.wb_sunny_rounded,
        isNext: nextPrayer == Prayer.sunrise,
      ),
      PrayerInfo(
        nameArabic: 'الظهر',
        time: pt.dhuhr,
        icon: Icons.wb_sunny_outlined,
        isNext: nextPrayer == Prayer.dhuhr,
      ),
      PrayerInfo(
        nameArabic: 'العصر',
        time: pt.asr,
        icon: Icons.filter_drama_rounded,
        isNext: nextPrayer == Prayer.asr,
      ),
      PrayerInfo(
        nameArabic: 'المغرب',
        time: pt.maghrib,
        icon: Icons.nights_stay_outlined,
        isNext: nextPrayer == Prayer.maghrib,
      ),
      PrayerInfo(
        nameArabic: 'العشاء',
        time: pt.isha,
        icon: Icons.bedtime_rounded,
        isNext: nextPrayer == Prayer.isha,
      ),
    ];
  }

  static Map<String, dynamic> getNextPrayerCountdown() {
    final pt = getPrayerTimes();
    final nextPrayer = pt.nextPrayer();
    DateTime? nextTime = pt.timeForPrayer(nextPrayer);
    String name = 'الفجر';

    if (nextPrayer == Prayer.none || nextTime == null) {
      // It's after Isha, so next is tomorrow's Fajr
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final tomorrowPt = getPrayerTimes(tomorrow);
      nextTime = tomorrowPt.fajr;
      name = 'الفجر (غداً)';
    } else {
      switch (nextPrayer) {
        case Prayer.fajr:
          name = 'الفجر';
          break;
        case Prayer.sunrise:
          name = 'الشروق';
          break;
        case Prayer.dhuhr:
          name = 'الظهر';
          break;
        case Prayer.asr:
          name = 'العصر';
          break;
        case Prayer.maghrib:
          name = 'المغرب';
          break;
        case Prayer.isha:
          name = 'العشاء';
          break;
        default:
          name = 'الصلاة القادمة';
      }
    }

    final diff = nextTime.difference(DateTime.now());
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    final seconds = diff.inSeconds.remainder(60);

    return {
      'prayerName': name,
      'time': nextTime,
      'duration': diff,
      'formattedRemaining': '${hours > 0 ? '$hours س ' : ''}$minutes د $seconds ث',
    };
  }
}
