import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/input_field.dart';

class ItemDetailCategoryWidget extends StatefulWidget {
  final Function(String? itemName, String description, String weight) callback;

  const ItemDetailCategoryWidget(this.callback, {Key? key}) : super(key: key);

  @override
  _ItemDetailCategoryWidgetState createState() =>
      _ItemDetailCategoryWidgetState();
}

class _ItemDetailCategoryWidgetState extends State<ItemDetailCategoryWidget> {
  String _pickItem = "Food";
  var itemsCategory = ["Food", "Cloth", "Electronics", "Others (specify)"];

  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _itemWeightCC = TextEditingController();

  final FocusNode _itemDescriptionNode = FocusNode();
  final FocusNode _itemWeightND = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _itemDescriptionController.dispose();
    _itemDescriptionNode.dispose();
    _itemWeightCC.dispose();
    _itemWeightND.dispose();
  }

  doCallback() => widget.callback(
      _pickItem, _itemDescriptionController.text, _itemWeightCC.text);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                  color: appPrimaryColor.withOpacity(0.5),
                  width: 0.3), //border of dropdown button
              borderRadius:
                  BorderRadius.circular(5.0), //border raiuds of dropdown button
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                value: _pickItem,
                hint: Text(
                  "choose category of item",
                  style: TextStyle(color: appPrimaryColor.withOpacity(0.3)),
                ),
                icon: const Icon(Remix.arrow_down_s_line),
                elevation: 16,
                isExpanded: true,
                style: theme.textTheme.bodyText2!.copyWith(
                  color: appPrimaryColor.withOpacity(0.8),
                ),
                underline: Container(),
                //empty line
                onChanged: (String? newValue) {
                  setState(() {
                    _pickItem = newValue!;
                  });
                  _itemDescriptionNode.requestFocus();
                  doCallback();
                },
                items: itemsCategory.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )),
        InputField(
          obscureText: false,
          text: '',
          hintText: 'Item details',
          textHeight: 0,
          node: _itemDescriptionNode,
          textController: _itemDescriptionController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          borderColor: appPrimaryColor.withOpacity(0.5),
          area: null,
          validator: (value) {
            if (value!.trim().length > 1) {
              return null;
            }
            return "Enter a valid item description";
          },
          onChanged: (value) {
            doCallback();
            return null;
          },
        ),
        InputField(
          obscureText: false,
          text: '',
          hintText: 'Item Weight',
          textHeight: 0,
          node: _itemWeightND,
          textController: _itemWeightCC,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          borderColor: appPrimaryColor.withOpacity(0.5),
          area: null,
          onChanged: (value) {
            doCallback();
            return null;
          },
        ),
      ],
    );
  }
}
