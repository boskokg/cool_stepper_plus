import 'package:flutter/material.dart';

class CoolStepperConfig {
  /// [backButton] Replaces the back default button
  /// [default] if null it will use custom design
  final Widget? backButton;

  /// [backText] Changes the text that should be displayed for the back button
  ///
  /// [default] is 'BACK'
  /// No effects if [backButton] is setted
  final String backText;

  /// [backTextStyle] Changes the text style for the back button
  ///
  /// [default] is TextStyle(color: Colors.grey)
  /// No effects if [backButton] is setted
  final TextStyle backTextStyle;

  /// [nextButton] Replaces the next default button
  /// [default] if null it will use custom design
  final Widget? nextButton;

  /// [nextText] Changes the text that should be displayed for the next button
  ///
  /// [default] is 'NEXT'
  /// No effects if [nextButton] is setted
  final String nextText;

  /// [nextTextStyle] Changes the text style for the next button
  ///
  /// [default] is TextStyle(color: Colors.green)
  /// No effects if [nextButton] is setted
  final TextStyle nextTextStyle;

  /// [nextButton] Replaces the next default button
  /// [default] if null it will use custom design
  final Widget? finishButton;

  /// The text that should be displayed for the next button on the final step
  ///
  /// [default] is 'FINISH'
  final String finalText;

  /// [stepText] Changes The text that describes the progress
  ///
  /// [default] is 'STEP'
  final String stepText;

  /// The text that describes the progress
  ///
  /// [default] is 'OF'
  final String ofText;

  /// [stepOfTextStyle] Changes the text style for the step x of x text
  ///
  /// [default] is TextStyle(color: Colors.green)
  /// No effects if [stepOfTextStyle] is setted
  final TextStyle stepOfTextStyle;

  /// This is the background color of the header
  final Color headerColor;

  /// [stepColor] will set the background color of the content,
  /// it is used when you want round corners
  final Color stepColor;

  /// This icon replaces the default icon
  final Icon icon;

  /// This is the textStyle for the title text
  final TextStyle titleTextStyle;

  /// This is the textStyle for the subtitle text
  final TextStyle subtitleTextStyle;

  /// [backTextList] Contains a list of string that when supplied will override [backText]
  ///
  /// Must be one less than the number of steps since for the first step, the [backText] won't be visible
  final List<String>? backTextList;

  /// [nextTextList] Contains a List of string that when supplied will override [nextText]
  ///
  /// Must be one less than the number of steps since the 'finalText' attribute is able to set the value for the final step's next button
  final List<String>? nextTextList;

  const CoolStepperConfig({
    this.nextButton,
    this.backButton,
    this.finishButton,
    this.backText = 'PREV',
    this.nextText = 'NEXT',
    this.stepText = 'STEP',
    this.ofText = 'OF',
    this.stepOfTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    this.headerColor = const Color(0xffbdbdbd),
    this.stepColor = Colors.transparent,
    this.icon = const Icon(
      Icons.help_outline,
      size: 18,
      color: Color(0x61000000),
    ),
    this.titleTextStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Color(0x61000000),
    ),
    this.subtitleTextStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Color(0xFF000000),
    ),
    this.backTextList,
    this.nextTextList,
    this.finalText = 'FINISH',
    this.nextTextStyle = const TextStyle(color: Colors.green),
    this.backTextStyle = const TextStyle(color: Colors.grey),
  });
}
