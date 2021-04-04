import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otte/ui/account/myPage.dart';
import 'package:otte/ui/eventLog/eventLogPage.dart';
import 'package:otte/ui/favorite/favoritedListPage.dart';
import 'package:otte/ui/shop/topPage.dart';

class Root extends StatefulWidget {
  const Root();

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedPage = 0;

  static const _enabledColor = Colors.black54;

  static const _disabledColor = Colors.grey;

  static const double _fontSize = 11;

  Widget _buildTabItem(
    IconData icon,
    double iconSize,
    String label,
    int index,
  ) =>
      Expanded(
        child: SizedBox(
          height: 60,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => setState(() {
                _selectedPage = index;
              }),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _selectedPage == index
                      ? Icon(
                          icon,
                          size: iconSize,
                          color: Colors.black54,
                        )
                      : Icon(icon, size: iconSize, color: Colors.grey[300]),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: _selectedPage == index
                            ? _enabledColor
                            : _disabledColor,
                        fontSize: _fontSize,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget _body(int selectedPage) {
    switch (selectedPage) {
      case 0:
        return TopPage();
      case 1:
        return FavoritedListPage();
      case 2:
        return EventLogPage();
      case 3:
        return MyPage();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _body(_selectedPage),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          notchMargin: 6.0,
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(),
            StadiumBorder(
              side: BorderSide(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildTabItem(
                  FontAwesomeIcons.shoppingBag,
                  22,
                  'ショップ',
                  0,
                ),
                _buildTabItem(
                  FontAwesomeIcons.heart,
                  22,
                  'お気に入り',
                  1,
                ),
                _buildTabItem(
                  FontAwesomeIcons.bell,
                  22,
                  'お知らせ',
                  2,
                ),
                _buildTabItem(
                  FontAwesomeIcons.userCircle,
                  22,
                  'アカウント',
                  3,
                ),
              ],
            ),
          ),
        ),
      );
}
