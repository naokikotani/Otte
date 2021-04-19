import 'package:flutter/material.dart';

import 'checkoutWebView.dart';

class CheckoutWebViewPusher {
  CheckoutWebViewPusher(this._context, {@required this.url, this.key});
  final BuildContext _context;
  final String url;
  final Key key;

  void push() {
    Navigator.of(_context).push<dynamic>(
      MaterialPageRoute<Widget>(
        settings: const RouteSettings(name: 'CheckoutWebView'),
        builder: (context) => CheckoutWebView(url: url, key: key),
      ),
    );
  }
}
