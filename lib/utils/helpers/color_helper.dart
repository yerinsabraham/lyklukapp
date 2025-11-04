import 'package:flutter/material.dart' show Color;

Color generateUserColor(String value) {
  final int hash = value.hashCode;
  final int red = (hash & 0xFF0000) >> 16; // Extract red
  final int green = (hash & 0x00FF00) >> 8; // Extract green
  final int blue = (hash & 0x0000FF); // Extract blue

  return Color.fromARGB(255, red, green, blue); // Always use full opacity (255)
}
