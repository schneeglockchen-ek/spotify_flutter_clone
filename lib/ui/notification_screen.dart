import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/route_helper.dart';
import 'package:spofity/helper/ui_helper.dart';
import 'package:spofity/ui/main_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  IconData iconPlay = IconHelper.playIcon;
  HomeScreenType selectedScreenIndex = HomeScreenType.home;
  static bool isIconPlayShown = true;

  @override
  void initState() {
    super.initState();
  }

  void onTapBottomNavigationBarItem(HomeScreenType selectedTabIndex) {
    setState(() {
      RouteHelper.goToScreen(context, MainScreen(selectedScreenIndex: selectedTabIndex));
      selectedScreenIndex = selectedTabIndex;
    });
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
      leading: UIHelper.createIcon(IconHelper.arrowLeftIcon, () {
        Navigator.pop(context);
      }),
      expandedHeight: 200,
    );
    // return Stack(
    //   alignment: Alignment.bottomCenter,
    //   children: [
    //     UIHelper.createInnerScreen(
    //       context,
    //       _createHeaderUnder(),
    //       _createHeader(),
    //       _createAltWidget(),
    //       leading: UIHelper.createIcon(CupertinoIcons.arrow_left, () {
    //         Navigator.pop(context);
    //       }),
    //       expandedHeight: 200,
    //       // statusBarHeight: 0
    //     ),
    //     UIHelper.createBottomMenu(context, onTapPlay: () {}, onTapBottomNavigationBarItem: _onItemTapped, 0),
    //   ],
    // );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return UIHelper.createScreen(
  //     context,
  //     _createHeaderUnder(),
  //     _createHeader(),
  //     _createAltWidget2(),
  //     UIHelper.createBottomMenu(
  //       context,
  //       selectedScreenIndex,
  //       iconPlay,
  //       onTapPlay: () {
  //         onTapPlay();
  //       },
  //       onTapBottomNavigationBarItem: (int selectedTabIndex) {
  //         onTapBottomNavigationBarItem(selectedTabIndex);
  //       },
  //     ),
  //     leading: UIHelper.createIcon(CupertinoIcons.arrow_left, () {
  //       Navigator.pop(context);
  //     }),
  //     expandedHeight: 200,
  //   );
  //   // return Stack(
  //   //   alignment: Alignment.bottomCenter,
  //   //   children: [
  //   //     UIHelper.createInnerScreen(
  //   //       context,
  //   //       _createHeaderUnder(),
  //   //       _createHeader(),
  //   //       _createAltWidget(),
  //   //       leading: UIHelper.createIcon(CupertinoIcons.arrow_left, () {
  //   //         Navigator.pop(context);
  //   //       }),
  //   //       expandedHeight: 200,
  //   //       // statusBarHeight: 0
  //   //     ),
  //   //     UIHelper.createBottomMenu(context, onTapPlay: () {}, onTapBottomNavigationBarItem: _onItemTapped, 0),
  //   //   ],
  //   // );
  // }

  Widget _createAltWidget2() {
    return Container(
      color: ColorHelper.shopifyBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createText(),
          _createAltWidget(),
        ],
      ),
    );
  }

  Widget _createHeaderUnder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UIHelper.createText(
          "Yenilikler",
          fontSize: 20,
          padding: const EdgeInsets.only(top: 60),
        )
      ],
    );
  }

  Widget _createHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        UIHelper.createText("Takip ettiğin sanatçılardan,podcast'lerden ve programlardan yeni çıkanlar.", textColor: ColorHelper.shopifyGreyLight, fontSize: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UIHelper.createOptions("Müzik"),
            UIHelper.createOptions("Podcast'ler ve Programlar"),
          ],
        ),
      ],
    );
  }

  Widget _createCardRowImageAndText() {
    return UIHelper.createCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(padding: const EdgeInsets.all(8), child: UIHelper.createImage()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.createTextNoPadding("5 gün önce", textColor: ColorHelper.shopifyGreyLight, fontSize: 12),
                    UIHelper.createTextNoPadding("Beğenilen Şarkılar"),
                    UIHelper.createTextNoPadding("Even Grinko", textColor: ColorHelper.shopifyGreyLight, fontSize: 12),
                  ],
                ),
              ],
            ),
            UIHelper.createText("Single", textColor: ColorHelper.shopifyGreyLight, fontSize: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UIHelper.createIcon(
                      IconHelper.likeIcon,
                      () {},
                    ),
                    UIHelper.createIcon(IconHelper.downloadIcon, () {}, color: ColorHelper.shopifyGreyLight),
                    UIHelper.createIcon(IconHelper.menuIcon, () {}, color: ColorHelper.shopifyGreyLight),
                  ],
                ),
                Row(
                  children: [
                    UIHelper.createIcon(IconHelper.play2Icon, () {}, size: 35),
                  ],
                )
              ],
            )
          ],
        ),
        color: ColorHelper.shopifyBlack);
  }

  Widget _createAltWidget() {
    return Expanded(
      child: GridView.count(
        // crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 2,
        crossAxisCount: 1,
        physics: const ClampingScrollPhysics(),
        children: List.generate(30, (index) {
          return _createCardRowImageAndText();
        }),
      ),
    );
  }

  Widget _createText() {
    return UIHelper.createText("Daha Eski", fontSize: 18);
  }
}
