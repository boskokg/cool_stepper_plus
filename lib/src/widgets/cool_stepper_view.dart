import 'package:cool_stepper_plus/cool_stepper_plus.dart';
import 'package:cool_stepper_plus/src/rounded_corner_container/rounded_corner_container.dart';
import 'package:flutter/material.dart';

/// [CoolStepperView] is the step builder, each step page is build here
class CoolStepperView extends StatelessWidget {
  /// [step] is the individual step widget
  final CoolStep step;

  /// [contentPadding] is the padding of the content inside the [step] content
  final EdgeInsetsGeometry contentPadding;

  /// [CoolStepperConfig] is the configuration of the widget, read the component to know it defaults values
  final CoolStepperConfig config;

  /// [isHeaderEnabled] enable the default header, if you want to build a custom title or header, disable this
  ///
  /// [default] is true
  final bool isHeaderEnabled;

  /// [hasRoundedCorner] enable the rounded corner between step and header
  ///
  /// [default] is true
  final bool hasRoundedCorner;

  const CoolStepperView({
    super.key,
    required this.step,
    required this.contentPadding,
    required this.config,
    required this.isHeaderEnabled,
    required this.hasRoundedCorner,
  });

  @override
  Widget build(BuildContext context) {
    /// [header] contains title, description and icon
    final header = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: config.headerColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  step.title.toUpperCase(),
                  style: config.titleTextStyle,
                  textAlign: config.titleTextAlign,
                  maxLines: 2,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: config.icon,
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Align(
            alignment: config.subtitleTextAlign,
            child: Text(
              step.subtitle,
              style: config.subtitleTextStyle,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );

    /// [body] is always show, this will contain the [step] content
    Widget body = Align(
      alignment: step.alignment,
      child: SingleChildScrollView(
        padding: contentPadding,
        child: step.content,
      ),
    );

    if (hasRoundedCorner) {
      body = RoundedCornerContainer(
        outsideColor: config.headerColor,
        insideColor: config.stepColor,
        child: body,
      );
    }

    return (isHeaderEnabled)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              Expanded(child: body),
            ],
          )
        : body;
  }
}
