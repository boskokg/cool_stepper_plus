import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// [CoolStep] is the step widget
class CoolStep {
  /// [title] is the title of the header of step page,
  ///  it will be shown as part of the header
  /// if isHeaderEnabled is not set to false
  final String title;

  /// [subtitle] is the subtitle of the header of step page,
  ///  it will be shown as part of the header
  /// if isHeaderEnabled is not set to false

  final String subtitle;

  /// [content] is the content of the header of step page,
  ///  it will be shown as part of the header
  /// if isHeaderEnabled is not set to false
  final Widget content;

  /// [validation] will be run to validate if user can go to next step,
  ///
  /// [default] value is null (no validation)
  final String? Function()? validation;

  /// [alignment] will customize [content] alignment between header (if enabled) and buttons
  ///
  /// [default] is [Alignment.topCenter]
  final Alignment alignment;

  static String? _noValidation() => null;

  CoolStep({
    required this.content,
    this.validation = _noValidation,
    this.title = '',
    this.subtitle = '',
    this.alignment = Alignment.topCenter,
  });
}
