import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/components/text_field_container.dart';

class RoundedRoleField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedRoleField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged, double width, DropdownButton<String> child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Color(0xFF6F35A5),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF6F35A5),
          ),
          hintText: 'Role',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
