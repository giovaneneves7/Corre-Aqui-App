import 'package:flutter/material.dart';

/// @author Giovane Neves
class StoreHour {
  final int weekday; // 0  for sunday, 6 for saturday
  final TimeOfDay openTime;
  final TimeOfDay closeTime;

  StoreHour({required this.weekday, required this.openTime, required this.closeTime});

  factory StoreHour.fromJson(Map<String, dynamic> json) {
    final openParts = (json['open_time'] as String).split(':');
    final closeParts = (json['close_time'] as String).split(':');

    return StoreHour(
      weekday: json['weekday'],
      openTime: TimeOfDay(hour: int.parse(openParts[0]), minute: int.parse(openParts[1])),
      closeTime: TimeOfDay(hour: int.parse(closeParts[0]), minute: int.parse(closeParts[1])),
    );
  }

  Map<String, dynamic> toJson() {
    String format(TimeOfDay t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    return {
      'weekday': weekday,
      'open_time': format(openTime),
      'close_time': format(closeTime),
    };
  }
}
