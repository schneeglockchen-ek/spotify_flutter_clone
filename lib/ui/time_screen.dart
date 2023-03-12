import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/route_helper.dart';
import 'package:spofity/helper/ui_helper.dart';
import 'package:spofity/ui/main_screen.dart';
import 'package:spofity/ui/music_screen.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({Key? key}) : super(key: key);

  @override
  State<TimeScreen> createState() => _TimeState();
}

class _TimeState extends State<TimeScreen> with TickerProviderStateMixin {
  AnimationController? controller;
  IconData iconPlay = IconHelper.playIcon;
  HomeScreenType selectedScreenIndex = HomeScreenType.home;
  static bool isIconPlayShown = true;
  static bool isIconLikeShown = true;
  IconData iconLike = IconHelper.likeIcon;
  Color colorBegen = ColorHelper.shopifyGreyLight;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UIHelper.createScreen(
      context,
      _createHeader(),
      _createHeaderUnder(),
      _createAltWidget2(context),
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
      leading: _createLeading(context),
      expandedHeight: 70,
      statusBarHeight: 70,
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

  Widget _createLeading(BuildContext context) {
    return UIHelper.createIcon(
      IconHelper.arrowLeftIcon,
      () {
        Navigator.pop(context);
      },
    );
  }

  Container _createAltWidget2(BuildContext context) {
    return Container(
      color: ColorHelper.shopifyBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.createText("Today", fontSize: 20),
          _createCardRowImageAndText(() {
            _modalBottomSheetMenu();
          }, icon: IconHelper.addIcon),
          Expanded(
            child: GridView.count(
              // crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 4,
              crossAxisCount: 1,
              physics: const ClampingScrollPhysics(),
              children: List.generate(30, (index) {
                return _createCardRowImageAndText(() {
                  RouteHelper.goToScreen(context, const MusicScreen());
                });
              }),
            ),
          ),
        ],
      ),
    );
  }

  Container _createHeaderUnder() => Container();

  Column _createHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _createHeaderUnder(),
        UIHelper.createText(
          "Yakınlarda Çalınanlar",
          fontSize: 20,
          padding: const EdgeInsets.only(top: 45),
        ),
      ],
    );
  }

  Widget _createCardRowImageAndText(Function onTap, {IconData? icon}) {
    icon ??= IconHelper.menuIcon;

    return UIHelper.createCard(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UIHelper.createImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.createText("Beğenilen Şarkılar"),
                UIHelper.createText("Çalma Listesi * Spotify", textColor: ColorHelper.shopifyGreyLight),
              ],
            ),
            Column(
              children: [
                UIHelper.createIcon(icon, () {
                  onTap();
                })
              ],
            )
          ],
        ),
        color: ColorHelper.shopifyBlack);
  }

  void _modalBottomSheetMenu() {
    controller = BottomSheet.createAnimationController(this);
    controller!.duration = const Duration(milliseconds: 500);
    showModalBottomSheet(
        transitionAnimationController: controller,
        isDismissible: false,
        barrierColor: ColorHelper.shopifyTransparent,
        backgroundColor: ColorHelper.shopifyBlack.withOpacity(0.9),
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) => Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 70),
                                Container(
                                  color: ColorHelper.shopifyBlack,
                                  child: UIHelper.createImage(
                                    width: 200,
                                  ),
                                ),
                                Column(
                                  children: [
                                    UIHelper.createText("Kurban", fontSize: 20),
                                    UIHelper.createText("Albüm * 2020", fontSize: 14, textColor: ColorHelper.shopifyGreyLight),
                                  ],
                                ),
                                Column(
                                  children: [
                                    _createCard(iconLike, "Beğen", color: colorBegen, () {
                                      onClickedLike(setState);
                                    }),
                                    _createCard(IconHelper.addPlaylistIcon, "Çalma Listesine Ekle", () {}),
                                    _createCard(IconHelper.addQueueIcon, "Sıraya Ekle", () {}),
                                    _createCard(IconHelper.showAlbumIcon, "Albümü Görüntüle", () {}),
                                    _createCard(IconHelper.showArtistIcon, "Sanatçıyı Görüntüle", () {}),
                                    _createCard(IconHelper.shareIcon, "Paylaş", () {}),
                                    _createCard(IconHelper.goSongRadioIcon, "Şarkı Radyosuna Git", () {}),
                                    _createCard(IconHelper.showContributersIcon, "Katkıda Bulunanları Göster", () {}),
                                    const SizedBox(height: 150),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      UIHelper.createIcon(
                        IconHelper.arrowLeftIcon,
                        () {
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.only(top: 50),
                      ),
                    ],
                  ));
        });
  }

  void onClickedLike(StateSetter setState) {
    setState(() {
      if (isIconLikeShown) {
        isIconLikeShown = false;
        iconLike = IconHelper.like2Icon;
        colorBegen = ColorHelper.shopifyGreen;
      } else {
        isIconLikeShown = true;
        iconLike = IconHelper.likeIcon;
        colorBegen = ColorHelper.shopifyGreyLight;
      }
    });
  }

  Widget _createCard(IconData icon, String text, Function onTap, {Color? color}) {
    color ??= ColorHelper.shopifyGreyLight;
    return Row(
      children: [
        UIHelper.createIcon(icon, () {
          onTap();
        }, color: color),
        UIHelper.createText(text, fontSize: 16),
      ],
    );
  }
}
