import 'package:flutter/material.dart';
import 'package:otte/ui/shop/selectSize/pusher.dart';

class AddCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: const Text('買い物かごへ追加'),
      color: Colors.black,
      textColor: Colors.white,
      onPressed: () {
        SelectSizePagePusher(context).push();
      },
    );
  }
}
