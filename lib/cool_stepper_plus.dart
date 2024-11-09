library cool_stepper_plus;

export 'package:cool_stepper_plus/src/models/cool_step.dart';
export 'package:cool_stepper_plus/src/models/cool_stepper_config.dart';

import 'package:another_flushbar/flushbar.dart';

import 'package:cool_stepper_plus/src/models/cool_step.dart';
import 'package:cool_stepper_plus/src/models/cool_stepper_config.dart';
import 'package:cool_stepper_plus/src/widgets/cool_stepper_view.dart';
import 'package:flutter/material.dart';

/// [CoolStepper] has two required params: [steps] and [onCompleted]
class CoolStepper extends StatefulWidget {
  /// The [steps] of the stepper whose titles, subtitles, content always get shown.
  ///
  /// The length of [steps] must not change.
  final List<CoolStep> steps;

  /// [onCompleted] is called at final step, use this to submit collected information
  final VoidCallback? onCompleted;

  /// [contentPadding] is the padding for the content inside the stepper
  ///
  ///  [default] value is EdgeInsets.zero (no Padding)
  final EdgeInsetsGeometry contentPadding;

  /// [CoolStepperConfig] is the widget configuration, set every text color and style
  final CoolStepperConfig config;

  /// [showErrorSnackbar] determines if or not a snackbar displays your error message if validation fails
  ///
  /// [default] is false
  final bool showErrorSnackbar;

  /// [isHeaderEnabled] determines if it will build with or without a header
  ///
  /// [default] is true
  final bool isHeaderEnabled;

  ///[hasRoundedCorner] enable the rounded corner between step and header
  ///
  /// [default] is true
  final bool hasRoundedCorner;

  const CoolStepper({
    required this.steps,
    this.onCompleted,
    this.contentPadding = EdgeInsets.zero,
    this.config = const CoolStepperConfig(),
    this.showErrorSnackbar = false,
    this.isHeaderEnabled = true,
    this.hasRoundedCorner = true,
  });

  @override
  CoolStepperState createState() => CoolStepperState();
}

class CoolStepperState extends State<CoolStepper> {
  final PageController _controller = PageController();

  int currentStep = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> switchToPage(int page) {
    return _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  bool _isFirst(int index) => (index == 0);

  bool _isLast(int index) => (widget.steps.length - 1 == index);

  void _doNothing() => {};
  void onStepNext() {
    final validation = widget.steps[currentStep].validation;

    /// [validation] is null, no validation rule
    if (validation == null || validation() == null) {
      if (!_isLast(currentStep)) {
        setState(() {
          currentStep++;
        });
        FocusScope.of(context).unfocus();
        switchToPage(currentStep);
      } else {
        final callback = widget.onCompleted ?? _doNothing;
        callback();
      }
      return;
    }

    /// [showErrorSnackbar] is false, No error snackbar rule
    if (!widget.showErrorSnackbar) {
      return;
    }

    /// [showErrorSnackbar] is true, Show error snackbar rule
    final flush = Flushbar(
      message: validation(),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8.0),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Theme.of(context).primaryColor,
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Theme.of(context).primaryColor,
    );
    flush.show(context);
  }

  void onStepBack() {
    if (!_isFirst(currentStep)) {
      setState(() {
        currentStep--;
      });
      switchToPage(currentStep);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Expanded(
      child: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: widget.steps.map((step) {
          return CoolStepperView(
            step: step,
            contentPadding: widget.contentPadding,
            config: widget.config,
            isHeaderEnabled: widget.isHeaderEnabled,
            hasRoundedCorner: widget.hasRoundedCorner,
          );
        }).toList(),
      ),
    );

    final counter = Container(
      child: Text(
        '${widget.config.stepText} ${currentStep + 1} ${widget.config.ofText} ${widget.steps.length}',
        style: widget.config.stepOfTextStyle,
      ),
    );

    String _getFinishLabel() => widget.config.finalText;

    String _getNextLabel() {
      String nextLabel;

      if (widget.config.nextTextList != null) {
        nextLabel = widget.config.nextTextList![currentStep];
      } else {
        nextLabel = widget.config.nextText;
      }

      return nextLabel;
    }

    String _getPreviousLabel() {
      String backLabel;

      if (widget.config.backTextList != null) {
        backLabel = widget.config.backTextList![currentStep - 1];
      } else {
        backLabel = widget.config.backText;
      }

      return backLabel;
    }

    Widget _backButton() {
      return GestureDetector(
        onTap: onStepBack,
        child: AbsorbPointer(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: _isFirst(currentStep) ? 0.0 : 1.0,
            child: widget.config.backButton ??
                Text(
                  _getPreviousLabel(),
                  style: widget.config.backTextStyle,
                ),
          ),
        ),
      );
    }

    Widget _nextButton() {
      if (_isLast(currentStep)) {
        return GestureDetector(
          onTap: onStepNext,
          child: AbsorbPointer(
            child: widget.config.finishButton ??
                Text(
                  _getFinishLabel(),
                  style: widget.config.nextTextStyle,
                ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: onStepNext,
          child: AbsorbPointer(
            child: widget.config.nextButton ??
                Text(
                  _getNextLabel(),
                  style: widget.config.nextTextStyle,
                ),
          ),
        );
      }
    }

    final buttons = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _backButton(),
          counter,
          _nextButton(),
        ],
      ),
    );

    return Container(
      child: Column(
        children: [
          content,
          buttons,
        ],
      ),
    );
  }
}
