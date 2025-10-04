import 'package:flutter/material.dart';

class ConfidenceLevelModel {
  final double confidence; // مستوى الثقة (0.0 إلى 100.0)
  final String title; // اسم الفئة
  final Color color; // لون الشريط

  ConfidenceLevelModel({required this.confidence, required this.title, required this.color});
}