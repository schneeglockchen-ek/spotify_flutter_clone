import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/home_helper.dart';
import 'package:spofity/helper/library_helper.dart';
import 'package:spofity/helper/route_helper.dart';
import 'package:spofity/helper/search_helper.dart';
import 'package:spofity/ui/main_screen.dart';
import 'package:spofity/ui/player_screen.dart';

class UIHelper {
  static Widget createScreen(
    BuildContext context,
    Widget widgetHeader,
    Widget ortaWidget,
    Widget altWidget,
    Widget bottomMenu, {
    double expandedHeight = 150,
    double statusBarHeight = 70,
    Widget? leading,
    double toolbarHeight = 70,
    double leadingWidth = 56.0,
    Function? isCollapsed,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _createInnerScreen(context, widgetHeader, ortaWidget, altWidget,
            leading: leading, expandedHeight: expandedHeight, toolbarHeight: toolbarHeight, statusBarHeight: statusBarHeight, leadingWidth: leadingWidth, isCollapsed: isCollapsed),
        bottomMenu,
      ],
    );
  }

  static Widget _createInnerScreen(
    BuildContext context,
    Widget widgetHeader,
    Widget ortaWidget,
    Widget altWidget, {
    double expandedHeight = 150,
    double statusBarHeight = 70,
    Widget? leading,
    double toolbarHeight = 70,
    double leadingWidth = 56.0,
    Function? isCollapsed,
  }) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: expandedHeight,
                collapsedHeight: statusBarHeight,
                floating: false,
                pinned: true,
                backgroundColor: ColorHelper.shopifyBlack,
                leading: leading ?? Container(),
                toolbarHeight: toolbarHeight,
                leadingWidth: leadingWidth,
                flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  if (isCollapsed != null) {
                    if (constraints.biggest.height != expandedHeight) {
                      isCollapsed(constraints.biggest.height);
                    }
                  }

                  return FlexibleSpaceBar(
                    expandedTitleScale: 1,
                    centerTitle: true,
                    title: ortaWidget,
                    background: Container(
                      color: ColorHelper.shopifyBlack,
                      child: widgetHeader,
                    ),
                  );
                }),
              ),
            ];
          },
          body: altWidget),
    );
  }

  static Widget createBottomMenu(
    BuildContext context,
    HomeScreenType selectedIndex,
    IconData iconPlay, {
    required Function onTapPlay,
    required Function(HomeScreenType) onTapBottomNavigationBarItem,
  }) {
    return Material(
      color: ColorHelper.shopifyBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          createPlayingNow(context, iconPlay, onTapPlay),
          Theme(
            data: ThemeData(
              splashColor: ColorHelper.shopifyTransparent,
              highlightColor: ColorHelper.shopifyTransparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: ColorHelper.shopifyBlack,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(IconHelper.homeIconPassive, color: ColorHelper.shopifyWhite),
                  label: '',
                  activeIcon: Container(
                    child: UIHelper.createIcon(IconHelper.homeIcon, color: ColorHelper.shopifyWhite, () {
                      onTapBottomNavigationBarItem(HomeScreenType.home);
                    }),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(IconHelper.searchPassiveIcon, color: ColorHelper.shopifyWhite),
                  label: '',
                  activeIcon: Container(
                    child: UIHelper.createIcon(IconHelper.searchIcon, color: ColorHelper.shopifyWhite, () {
                      onTapBottomNavigationBarItem(HomeScreenType.search);
                    }),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(IconHelper.libraryPassiveIcon, color: ColorHelper.shopifyWhite),
                  label: '',
                  activeIcon: Container(
                    child: UIHelper.createIcon(IconHelper.libraryIcon, color: ColorHelper.shopifyWhite, () {
                      onTapBottomNavigationBarItem(HomeScreenType.library);
                    }),
                  ),
                ),
              ],
              currentIndex: getCurrentIndex(selectedIndex),
              onTap: (value) {
                HomeScreenType homeScreenType;
                switch (value) {
                  case 1:
                    homeScreenType = HomeScreenType.search;
                    break;
                  case 2:
                    homeScreenType = HomeScreenType.library;
                    break;
                  case 0:
                  default:
                    homeScreenType = HomeScreenType.home;
                    break;
                }

                onTapBottomNavigationBarItem(homeScreenType);
              },
            ),
          ),
        ],
      ),
    );
  }

  static int getCurrentIndex(HomeScreenType selectedIndex) {
    switch (selectedIndex) {
      case HomeScreenType.search:
        return 1;
      case HomeScreenType.library:
        return 2;
      case HomeScreenType.home:
      default:
        return 0;
    }
  }

  static createPlayingNow(BuildContext context, IconData iconPlay, Function onTapPlay) {
    return InkWell(
      onTap: () {
        RouteHelper.goToScreen(context, const PlayerScreen());
      },
      child: UIHelper.createCard(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                UIHelper.createCard(UIHelper.createImage(width: 40)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.createTextNoPadding("Yıldızların Altında"),
                    UIHelper.createTextNoPadding("Kargo", textColor: ColorHelper.shopifyGreyLight),
                  ],
                )
              ],
            ),
            Row(
              children: [
                UIHelper.createIcon(IconHelper.deviceIcon, () {}),
                UIHelper.createIcon(IconHelper.likeIcon, () {}),
                UIHelper.createIcon(iconPlay, () {
                  onTapPlay();
                }),
              ],
            )
          ],
        ),
      )),
    );
  }

  static Widget createPodcast() {
    return UIHelper.createCard(
      color: ColorHelper.shopifyBlack,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UIHelper.createCard(UIHelper.createImage(width: 130), radius: 15),
          //todo expanded
          SizedBox(
            height: 130,
            width: 200, //todo:bir değer vermeyince yazı uzadıkça ekrandan taşıyor.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UIHelper.createText("datajıhjgfdsaxgfcgvnbnhjgyuhgyfthdgxfcgvhb"),
                UIHelper.createIcon(IconHelper.addCircleIcon, () {}),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UIHelper.createIcon(
                      IconHelper.play2Icon,
                      () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static createCard(Widget widget, {double radius = 5, Color? color, BorderSide? borderSide}) {
    color = color ?? Colors.grey.shade900;
    borderSide = borderSide ?? const BorderSide(color: ColorHelper.shopifyTransparent);
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        side: borderSide,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRect(
        child: widget,
      ),
    );
  }

  static createOptions(String text) {
    return UIHelper.createCard(
      UIHelper.createText(text, fontWeight: FontWeight.normal),
      radius: 20,
      color: ColorHelper.shopifyBlack,
      borderSide: const BorderSide(color: ColorHelper.shopifyWhite),
    );
  }

  static createText(
    String text, {
    FontWeight fontWeight = FontWeight.bold,
    double fontSize = 14,
    Color textColor = ColorHelper.shopifyWhite,
    EdgeInsetsGeometry padding = const EdgeInsets.only(left: 14, right: 14, bottom: 8, top: 8),
  }) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: fontWeight, fontSize: fontSize),
      ),
    );
  }

  static createTextNoPadding(
    String text, {
    FontWeight fontWeight = FontWeight.bold,
    double fontSize = 14,
    Color textColor = ColorHelper.shopifyWhite,
  }) {
    return createText(
      text,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textColor: textColor,
      padding: const EdgeInsets.all(0),
    );
  }

  static createIcon(
    IconData icon,
    Function onTap, {
    double? size = 25,
    Color? color = ColorHelper.shopifyWhite,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8),
  }) {
    return Padding(
      padding: padding,
      child: InkWell(
          splashColor: ColorHelper.shopifyTransparent,
          highlightColor: ColorHelper.shopifyTransparent,
          onTap: () {
            onTap();
          },
          child: Icon(icon, color: color, size: size)),
    );
  }

  static createImage({double width = 70, String image = "assets/images/rush.png"}) {
    return Image.asset(
      image,
      width: width,
      fit: BoxFit.cover,
    );
  }

  static Widget getLibraryScreen(
    BuildContext context,
    IconData iconChangeLayout,
    LibraryScreenContentType libraryScreenContentType, {
    required Function onTapList,
    required Function onTapGrid,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        UIHelper._createInnerScreen(
            context,
            LibraryHelper.createHeader(),
            LibraryHelper.createHeaderUnder(),
            LibraryHelper.createLibraryScreenContent(
              context,
              iconChangeLayout,
              libraryScreenContentType,
              onTapList: () {
                onTapList();
              },
              onTapGrid: () {
                onTapGrid();
              },
            )),
      ],
    );
  }

  static Widget getSearchScreen(
    BuildContext context,
  ) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        UIHelper._createInnerScreen(
          context,
          SearchHelper.createSearchHeader(),
          SearchHelper.createSearchField(),
          SearchHelper.createSearchScreenContent(context),
        ),
      ],
    );
  }

  static Widget getHomeScreen(
    BuildContext context,
    HomeScreenContentType homeScreenContextIndex,
    Color cardColor,
    Color textColor, {
    required Function onClickedHomeScreenClose,
    required Function onClickedHomeScreenMusic,
    required Function onClickedHomeScreenPodcast,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        UIHelper._createInnerScreen(
          context,
          HomeHelper.createHomeHeader(context),
          HomeHelper.createHomeHeaderUnder(
            homeScreenContextIndex,
            cardColor: cardColor,
            textColor: textColor,
            onTapCloseIcon: () {
              onClickedHomeScreenClose();
            },
            onTapMusicButton: () {
              onClickedHomeScreenMusic();
            },
            onTapPodcastButton: () {
              onClickedHomeScreenPodcast();
            },
          ),
          HomeHelper.createHomeScreenContent(context, homeScreenContextIndex),
        ),
      ],
    );
  }
}
