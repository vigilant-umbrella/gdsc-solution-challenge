import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Tag {
  final String name;
  final int id;

  Tag(this.name, this.id);
}

class DropDownMultiSelect extends StatefulWidget {
  final Function onSelected;

  const DropDownMultiSelect({Key? key, required this.onSelected})
      : super(key: key);

  @override
  State<DropDownMultiSelect> createState() => _DropDownMultiSelectState();
}

class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
  List<String> _selectedItems = [];

  final List<Tag> _availableTags = [
    Tag('Tag 1', 1),
    Tag('Tag 2', 2),
    Tag('Tag 3', 3),
    Tag('Tag 4', 4),
    Tag('Tag 5', 5),
    Tag('Tag 6', 6),
    Tag('Tag 7', 7),
    Tag('Tag 8', 8),
    Tag('Tag 9', 9),
    Tag('Tag 10', 10),
    Tag('Tag 11', 11),
    Tag('Tag 12', 12),
    Tag('Tag 13', 13),
    Tag('Tag 14', 14),
    Tag('Tag 15', 15),
    Tag('Tag 16', 16),
    Tag('Tag 17', 17),
    Tag('Tag 18', 18),
    Tag('Tag 19', 19),
    Tag('Tag 20', 20),
    Tag('Tag 21', 21),
    Tag('Tag 22', 22),
    Tag('Tag 23', 23),
    Tag('Tag 24', 24),
    Tag('Tag 25', 25),
    Tag('Tag 26', 26),
    Tag('Tag 27', 27),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      height: 55 + (55 * ((_selectedItems.length / 4).ceil().toDouble())),
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: BorderRadius.circular(8),
      child: MultiSelectDialogField(
        buttonIcon: const Icon(Icons.tag, color: Colors.white),
        buttonText: const Text(
          "Select tags",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        searchable: true,
        searchHint: 'Search tags',
        items: _availableTags
            .map((tag) => MultiSelectItem<String>(tag.name, tag.name))
            .toList(),
        onConfirm: (List<String> selected) {
          widget.onSelected(selected);
          setState(() {
            _selectedItems = selected;
          });
        },
      ),
    );
  }
}
