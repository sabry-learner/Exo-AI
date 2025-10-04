import 'package:flutter/material.dart';

class PieChartDataModel {
  final double value; // النسبة المئوية
  final String title; // اسم الفئة
  final Color color; // لون القطاع

  PieChartDataModel({required this.value, required this.title, required this.color});
}