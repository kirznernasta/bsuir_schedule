import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../presentation.dart';

enum _InputState {
  inputDefault,
  inputValid,
  inputInvalid,
}

class _ValidationState {
  final _InputState inputState;
  final String? errorText;

  const _ValidationState({required this.inputState, this.errorText});

  const _ValidationState.initial()
      : inputState = _InputState.inputDefault,
        errorText = null;
}

class InputFormField extends StatefulWidget {
  final FocusNode focusNode;
  final bool showInitialLabel;
  final bool hasCancelButton;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  final String Function(String) onInputChanged;
  final Future<String> Function(String) onInputCompleted;
  final int? maxLines;
  final String? hintText;
  final SvgGenImage? prefixIcon;
  final SvgGenImage? suffixIcon;
  final VoidCallback? onIconPressed;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? validator;

  const InputFormField({
    required this.focusNode,
    required this.onInputChanged,
    required this.onInputCompleted,
    required this.textEditingController,
    this.obscureText = false,
    this.hasCancelButton = true,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.showInitialLabel = false,
    this.maxLines = 1,
    this.validator,
    this.formatters,
    this.prefixIcon,
    this.suffixIcon,
    this.onIconPressed,
    super.key,
  });

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  late final labelVisibilityNotifier = ValueNotifier(widget.showInitialLabel);
  final validatorNotifier = ValueNotifier<_ValidationState>(
    const _ValidationState.initial(),
  );

  String errorText = '';

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(focusListener);
    widget.textEditingController.addListener(textListener);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.r);
    final prefixIcon = widget.prefixIcon;

    return ValueListenableBuilder(
      valueListenable: validatorNotifier,
      builder: (_, state, __) {
        String text;
        TextStyle? textStyle;

        if (state.inputState == _InputState.inputInvalid) {
          text = errorText;
        } else {
          text = '';
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDCDCD),
                      borderRadius: borderRadius,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: GestureDetector(
                              onTap: () => widget.focusNode.requestFocus(),
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                children: [
                                  if (prefixIcon != null) ...[
                                    prefixIcon.svg(
                                      width: 24.w,
                                      colorFilter: Colors.grey.colorFilter,
                                    ),
                                    SizedBox(width: 4.w),
                                  ],
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          scrollPadding: EdgeInsets.zero,
                                          key: widget.key,
                                          controller:
                                              widget.textEditingController,
                                          focusNode: widget.focusNode,
                                          onChanged: _onChangedHandler,
                                          onFieldSubmitted: _onInputCompleted,
                                          decoration: InputDecoration(
                                            isDense: false,
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: widget.hintText,
                                          ),
                                          inputFormatters: widget.formatters,
                                          keyboardType: widget.keyboardType,
                                          obscureText: widget.obscureText,
                                          obscuringCharacter: '∗',
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (widget.suffixIcon != null)
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      splashRadius: 12.r,
                                      onPressed: widget.onIconPressed,
                                      icon: widget.suffixIcon!.svg(
                                        width: 24.w,
                                        colorFilter: Colors.grey.colorFilter,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.focusNode.hasFocus && widget.hasCancelButton) ...[
                  SizedBox(width: 24.w),
                  GestureDetector(
                    onTap: cancelInput,
                    child: Text(
                      'Cancel',
                      style: context.theme.textTheme.bodyLarge?.copyWith(
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (text.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
          ],
        );
      },
    );
  }

  void textListener() {
    final text = widget.textEditingController.text;
    final isLabelVisible = text.isNotEmpty;

    labelVisibilityNotifier.value = isLabelVisible;
  }

  void focusListener() => setState(() {});

  void cancelInput() {
    widget.textEditingController.text = '';
    widget.onInputCompleted('');
    widget.focusNode.unfocus();
  }

  void _onChangedHandler(String text) {
    final isEmptyText = text.isEmpty;

    errorText = widget.onInputChanged(text);

    if (isEmptyText || errorText.isNotEmpty) {
      validatorNotifier.value = _ValidationState(
        inputState: _InputState.inputInvalid,
        errorText: errorText,
      );
    } else {
      validatorNotifier.value = const _ValidationState(
        inputState: _InputState.inputValid,
      );
    }
  }

  Future<void> _onInputCompleted(String text) async {
    errorText = await widget.onInputCompleted(text);

    if (errorText.isNotEmpty) {
      validatorNotifier.value = _ValidationState(
        inputState: _InputState.inputInvalid,
        errorText: errorText,
      );
    } else {
      validatorNotifier.value = const _ValidationState(
        inputState: _InputState.inputValid,
      );
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(focusListener);
    widget.textEditingController.removeListener(textListener);
    labelVisibilityNotifier.dispose();

    super.dispose();
  }
}
