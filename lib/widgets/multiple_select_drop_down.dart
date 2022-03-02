import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class _TheState {}

var _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow(
      {Key? key,
      required this.onChange,
      required this.selected,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: selected,
            onChanged: (x) {
              onChange(x!);
              _theState.notify();
            }),
        Text(text)
      ],
    );
  }
}

class DropDownMultiSelect extends StatefulWidget {
  /// The options form which a user can select
  final List<String> options;

  /// Selected Values
  final List<String> selectedValues;

  /// This function is called whenever a value changes
  final Function(List<String>) onChanged;

  /// this text is shown when there is no selection
  final String? whenEmpty;

  /// a function to build custom childern
  final Widget Function(List<String> selectedValues)? childBuilder;

  /// a function to build custom menu items
  final Widget Function(String option)? menuItembuilder;

  /// a function to validate
  final String Function(String? selectedOptions)? validator;

  /// defines whether the widget is read-only
  final bool readOnly;

  const DropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.whenEmpty,
    this.childBuilder,
    this.menuItembuilder,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _DropDownMultiSelectState createState() => _DropDownMultiSelectState();
}

class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: [
          _theState.rebuild(() => widget.childBuilder != null
              ? widget.childBuilder!(widget.selectedValues)
              : Align(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Text(widget.selectedValues.isNotEmpty
                          ? widget.selectedValues
                              .reduce((a, b) => a + ' , ' + b)
                          : widget.whenEmpty ?? '')),
                  alignment: Alignment.centerLeft)),
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButtonFormField<String>(
              validator: (widget.validator != null) ? widget.validator : null,
              icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: Colors.white,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
              ),
              onChanged: (x) {},
              value: widget.selectedValues.isNotEmpty
                  ? widget.selectedValues[0]
                  : null,
              selectedItemBuilder: (context) {
                return widget.options
                    .map((e) => DropdownMenuItem(
                          child: Container(),
                        ))
                    .toList();
              },
              items: widget.options
                  .map((x) => DropdownMenuItem(
                        child: _theState.rebuild(() {
                          return widget.menuItembuilder != null
                              ? widget.menuItembuilder!(x)
                              : _SelectRow(
                                  selected: widget.selectedValues.contains(x),
                                  text: x,
                                  onChange: (isSelected) {
                                    if (isSelected) {
                                      var ns = widget.selectedValues;
                                      ns.add(x);
                                      widget.onChanged(ns);
                                    } else {
                                      var ns = widget.selectedValues;
                                      ns.remove(x);
                                      widget.onChanged(ns);
                                    }
                                  },
                                );
                        }),
                        value: x,
                        onTap: !widget.readOnly
                            ? () {
                                if (widget.selectedValues.contains(x)) {
                                  var ns = widget.selectedValues;
                                  ns.remove(x);
                                  widget.onChanged(ns);
                                } else {
                                  var ns = widget.selectedValues;
                                  ns.add(x);
                                  widget.onChanged(ns);
                                }
                              }
                            : null,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
