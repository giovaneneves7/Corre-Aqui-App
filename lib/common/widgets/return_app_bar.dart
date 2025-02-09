import 'package:flutter/material.dart';

/**
* Custom AppBar
* @author Giovane
* @since v0.0.1
*/
class ReturnAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  final title;
  @override
  final Size preferredSize; 

  ReturnAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(title),
    );
  }
}
