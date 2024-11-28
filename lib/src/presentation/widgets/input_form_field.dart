import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../presentation.dart';

class InputFormField extends StatefulWidget {
  final FocusNode focusNode;
  final bool showInitialLabel;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  final String Function(String) onInputChanged;
  final Future<String> Function(String) onInputCompleted;
  final int? maxLines;
  final String? hintText;
  final SvgGenImage? prefixIcon;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? validator;

  const InputFormField({
    required this.focusNode,
    required this.onInputChanged,
    required this.onInputCompleted,
    required this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.showInitialLabel = false,
    this.maxLines = 1,
    this.validator,
    this.formatters,
    this.prefixIcon,
    super.key,
  });

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  late final labelVisibilityNotifier = ValueNotifier(widget.showInitialLabel);

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

    return Row(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  scrollPadding: EdgeInsets.zero,
                                  key: widget.key,
                                  controller: widget.textEditingController,
                                  focusNode: widget.focusNode,
                                  onChanged: widget.onInputChanged,
                                  onFieldSubmitted: widget.onInputCompleted,
                                  decoration: InputDecoration(
                                    isDense: false,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    errorStyle: const TextStyle(
                                      fontSize: 0,
                                      height: 0,
                                    ),
                                    disabledBorder: InputBorder.none,
                                    hintText: widget.hintText,
                                  ),
                                  inputFormatters: widget.formatters,
                                  keyboardType: widget.keyboardType,
                                ),
                              ],
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
        if (widget.focusNode.hasFocus) ...[
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

  @override
  void dispose() {
    widget.focusNode.removeListener(focusListener);
    widget.textEditingController.removeListener(textListener);
    labelVisibilityNotifier.dispose();

    super.dispose();
  }
}
