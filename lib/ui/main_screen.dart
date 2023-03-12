import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/home_helper.dart';
import 'package:spofity/helper/ui_helper.dart';

class MainScreen extends StatefulWidget {
  final HomeScreenType selectedScreenIndex;

  const MainScreen({Key? key, required this.selectedScreenIndex}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomeScreenType selectedScreenIndex = HomeScreenType.home;
  HomeScreenContentType homeScreenContextIndex = HomeScreenContentType.home;
  Color textColor = ColorHelper.shopifyWhite;
  Color cardColor = Colors.grey.shade900;
  IconData iconPlay = IconHelper.playIcon;
  static bool isIconPlayShown = true;
  LibraryScreenContentType libraryScreenContentType = LibraryScreenContentType.list;
  late IconData iconChangeLayout;

  @override
  void initState() {
    selectedScreenIndex = widget.selectedScreenIndex;
    iconChangeLayout = IconHelper.gridIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: getScreen(selectedScreenIndex)),
      bottomNavigationBar: UIHelper.createBottomMenu(
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
    );
  }

  void onTapBottomNavigationBarItem(HomeScreenType selectedTabIndex) {
    setState(() {
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

  Widget getScreen(HomeScreenType selectedIndex) {
    switch (selectedIndex) {
      case HomeScreenType.home:
        return UIHelper.getHomeScreen(
          context,
          homeScreenContextIndex,
          cardColor,
          textColor,
          onClickedHomeScreenClose: () {
            onClickedHomeScreenClose();
          },
          onClickedHomeScreenMusic: () {
            onClickedHomeScreenMusic();
          },
          onClickedHomeScreenPodcast: () {
            onClickedHomeScreenPodcast();
          },
        );
      case HomeScreenType.search:
        return UIHelper.getSearchScreen(context);
      case HomeScreenType.library:
        return UIHelper.getLibraryScreen(
          context,
          iconChangeLayout,
          libraryScreenContentType,
          onTapGrid: () {
            setState(() {
              libraryScreenContentType = LibraryScreenContentType.list;
              iconChangeLayout = IconHelper.gridIcon;
            });
          },
          onTapList: () {
            setState(() {
              libraryScreenContentType = LibraryScreenContentType.grid;
              iconChangeLayout = IconHelper.listIcon;
            });
          },
        );
      default:
        return Container();
    }
  }

  void onClickedHomeScreenPodcast() {
    setState(() {
      homeScreenContextIndex = HomeScreenContentType.podcast;
      textColor = ColorHelper.shopifyBlack;
      cardColor = ColorHelper.shopifyGreen;
    });
  }

  void onClickedHomeScreenMusic() {
    setState(() {
      homeScreenContextIndex = HomeScreenContentType.music;
      textColor = ColorHelper.shopifyBlack;
      cardColor = ColorHelper.shopifyGreen;
    });
  }

  void onClickedHomeScreenClose() {
    setState(() {
      homeScreenContextIndex = HomeScreenContentType.home;
      textColor = ColorHelper.shopifyWhite;
      cardColor = Colors.grey.shade900;
    });
  }
}

enum HomeScreenType {
  home,
  search,
  library,
}
