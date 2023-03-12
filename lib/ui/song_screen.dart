import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/route_helper.dart';
import 'package:spofity/helper/ui_helper.dart';
import 'package:spofity/ui/main_screen.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool isVisible = true;
  double currentHeight = -1;
  double previousHeight = 0;
  IconData iconPlay = IconHelper.playIcon;
  HomeScreenType selectedScreenIndex = HomeScreenType.home;
  static bool isIconPlayShown = true;

  Widget _createHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UIHelper.createCard(
          Row(
            children: [
              UIHelper.createIcon(IconHelper.search2Icon, () {}),
              UIHelper.createText("Beğenilen şarkılarda bul"),
            ],
          ),
        ),
        UIHelper.createCard(UIHelper.createText("Sırala", padding: const EdgeInsets.all(12))),
      ],
    );
  }

  Widget _createHeaderUnder() {
    return Visibility(
      visible: !isVisible,
      child: UIHelper.createText(
        "Beğenilen Şarkılar",
        fontSize: 20,
        padding: const EdgeInsets.only(bottom: 10),
      ),
    );
  }

  Widget _createAltWidget2() {
    return Container(
      color: ColorHelper.shopifyBlack,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.createText("Liked Songs", fontSize: 20),
            UIHelper.createText("250 Şarkı", textColor: ColorHelper.shopifyGreyLight, fontSize: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UIHelper.createIcon(IconHelper.downloadIcon, () {}, color: ColorHelper.shopifyGreen, size: 20),
                  ],
                ),
                Row(children: [
                  UIHelper.createIcon(IconHelper.shuffleIcon, () {}, color: ColorHelper.shopifyGreen),
                  UIHelper.createIcon(IconHelper.play2Icon, () {}, size: 35, color: ColorHelper.shopifyGreen),
                ]),
              ],
            ),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
            _createCardRowImageAndText(),
          ],
        ),
      ),
    );
  }

  _isCollapsed(double height) async {
    previousHeight = currentHeight;
    currentHeight = height;

    if (!mounted) return false;
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;

      if (previousHeight != currentHeight) {
        setState(() {
          isVisible = height > 150;
        });
      }
    }
  }

  _createLeading() {
    return Row(
      children: [
        UIHelper.createIcon(
          IconHelper.arrowLeftIcon,
          () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void onTapPlay() {
    setState(() {
      if (isIconPlayShown) {
        isIconPlayShown = false;
        iconPlay = IconHelper.pauseIcon;
      } else {
        isIconPlayShown = true;
        iconPlay = IconHelper.playIcon;
      }
    });
  }

  void onTapBottomNavigationBarItem(HomeScreenType selectedTabIndex) {
    setState(() {
      RouteHelper.goToScreen(context, MainScreen(selectedScreenIndex: selectedTabIndex));
      selectedScreenIndex = selectedTabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UIHelper.createScreen(
      context,
      _createHeader(),
      _createHeaderUnder(),
      _createAltWidget2(),
      UIHelper.createBottomMenu(
        context,
        selectedScreenIndex,
        iconPlay,
        onTapPlay: () {
          onTapPlay();
        },
        onTapBottomNavigationBarItem: (HomeScreenType selectedTabIndex) {
          onTapBottomNavigationBarItem(selectedTabIndex);
        },
      ),
      toolbarHeight: 100,
      leadingWidth: 300,
      leading: _createLeading(),
      expandedHeight: 210,
      statusBarHeight: 100,
      isCollapsed: (double height) async {
        _isCollapsed(height);
      },
    );
  }

  Widget _createCardRowImageAndText() {
    return UIHelper.createCard(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UIHelper.createImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.createText("Liked Songs"),
                Row(
                  children: [
                    UIHelper.createIcon(IconHelper.downloadIcon, () {}, color: ColorHelper.shopifyGreen, size: 20),
                    UIHelper.createTextNoPadding(
                      "Çalma Listesi *Spotify",
                      textColor: ColorHelper.shopifyGreyLight,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Row(children: [
              UIHelper.createIcon(IconHelper.likeIcon, () {}, color: ColorHelper.shopifyGreen),
              UIHelper.createIcon(IconHelper.menuIcon, () {}),
            ])
          ],
        ),
        color: ColorHelper.shopifyBlack);
  }
}
