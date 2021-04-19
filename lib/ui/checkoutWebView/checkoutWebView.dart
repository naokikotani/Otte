import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otte/globalViewModel/checkoutViewModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutWebView extends StatefulWidget {
  const CheckoutWebView({@required this.url, Key key}) : super(key: key);
  final String url;

  @override
  CheckoutWebViewState createState() => CheckoutWebViewState();
}

class CheckoutWebViewState extends State<CheckoutWebView> {
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _checkoutCompleted = false;
  bool _checkoutProcessing = false;
  WebViewController _controller;

  CheckoutViewModel get _checkoutViewModel =>
      context.read(checkoutViewModelProvider);

  Future<void> _getUrl() async {
    final url = await _controller.currentUrl();
    print(url);
    // サンクスページのURLは最後thank_youになっている
    if (url.contains('/processing')) {
      setState(() {
        _checkoutProcessing = true;
      });
      print('Checkout is processing');
    }
    if (url.contains('/thank_you')) {
      setState(() {
        _checkoutProcessing = false;
        _checkoutCompleted = true;
      });
      print('Thank you');
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading:
                !(_checkoutCompleted || _checkoutProcessing),
            // 決済完了後(サンクスページ)でAppBarの戻るボタンを削除
            leading: _checkoutCompleted || _checkoutProcessing
                ? Container()
                : IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              'お支払い',
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 10,
            // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
            actions: <Widget>[
              NavigationControls(_controllerCompleter.future),
            ],
          ),
          // We're using a Builder here so we have a context that is below the Scaffold
          // to allow calling Scaffold.of(context) so we can show a snackbar.
          body: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                onPageFinished: (_) {
                  _getUrl();
                },
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (webViewController) {
                  setState(() {
                    _controller = webViewController;
                  });
                },
              ),
              // サンクスページで画面下に戻るボタンを表示
              _checkoutCompleted
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonBar(
                          buttonHeight: 50,
                          buttonMinWidth: 200,
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.blue,
                              child: const Text(
                                'お買い物を続ける',
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                _checkoutViewModel.completeCheckout();
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) => FutureBuilder<WebViewController>(
        future: _webViewControllerFuture,
        builder: (context, snapshot) {
          final webViewReady = snapshot.connectionState == ConnectionState.done;
          final controller = snapshot.data;
          return Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (webViewReady) {
                    return;
                  }
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  } else {
                    Scaffold.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'No back history item',
                        ),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.replay,
                ),
                onPressed: !webViewReady ? null : controller.reload,
              ),
            ],
          );
        },
      );
}
