import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/route_helper.dart';
import 'package:spofity/helper/ui_helper.dart';
import 'package:spofity/ui/music_screen.dart';
import 'package:spofity/ui/notification_screen.dart';
import 'package:spofity/ui/settings_screen.dart';
import 'package:spofity/ui/song_screen.dart';
import 'package:spofity/ui/time_screen.dart';

enum HomeScreenContentType {
  home,
  music,
  podcast,
}

enum LibraryScreenContentType {
  list,
  grid,
}

class HomeHelper {
  static Widget createHomeHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UIHelper.createText(
          "Tünaydın",
          fontSize: 20,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UIHelper.createIcon(IconHelper.notificationIcon, () {
              RouteHelper.goToScreen(context, const NotificationScreen());
            }),
            UIHelper.createIcon(
              IconHelper.timeIcon,
              () {
                RouteHelper.goToScreen(context, const TimeScreen());
              },
            ),
            UIHelper.createIcon(
              IconHelper.settingIcon,
              () {
                RouteHelper.goToScreen(context, const SettingsScreen());
              },
            ),
          ],
        ),
      ],
    );
  }

  static Widget createHomeHeaderUnder(
    HomeScreenContentType homeScreenContextIndex, {
    required Function onTapCloseIcon,
    required Function onTapMusicButton,
    required Function onTapPodcastButton,
    required Color textColor,
    required Color cardColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
            visible: homeScreenContextIndex != HomeScreenContentType.home,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.grey.shade900),
              child: UIHelper.createIcon(IconHelper.closeIcon, () {
                onTapCloseIcon();
                //RouteHelper.goToScreen(context, HomeScreen());
              }),
            )),
        InkWell(
            hoverColor: ColorHelper.shopifyTransparent,
            splashColor: ColorHelper.shopifyTransparent,
            onTap: () {
              onTapMusicButton();
              //  _createMusic();
              // RouteHelper.goToScreen(context, MusicScreen());
            },
            child: Visibility(
              visible: homeScreenContextIndex != HomeScreenContentType.podcast,
              child: UIHelper.createCard(
                UIHelper.createText("Müzik", fontWeight: FontWeight.normal, textColor: textColor),
                radius: 20,
                color: cardColor,
              ),
            )),
        InkWell(
          hoverColor: ColorHelper.shopifyTransparent,
          splashColor: ColorHelper.shopifyTransparent,
          onTap: () {
            onTapPodcastButton();
          },
          child: Visibility(
            visible: homeScreenContextIndex != HomeScreenContentType.music,
            child: UIHelper.createCard(
              UIHelper.createText("Postcast'ler ve Programlar", fontWeight: FontWeight.normal, textColor: textColor),
              radius: 20,
              color: cardColor,
            ),
          ),
        ),
      ],
    );
  }

  static Widget createHomeScreenContent(BuildContext context, HomeScreenContentType homeScreenContextIndex) {
    switch (homeScreenContextIndex) {
      case HomeScreenContentType.home:
        return HomeHelper.createHomeScreenContentHome(context);
      case HomeScreenContentType.music:
        return HomeHelper.createHomeScreenContentMusic();
      case HomeScreenContentType.podcast:
        return HomeHelper.createHomeScreenContentPodcast();
      default:
        return Container();
    }
  }

  static Widget createHomeScreenContentHome(BuildContext context) {
    return Container(
        color: ColorHelper.shopifyBlack,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createCardImageAndText(context),
              UIHelper.createText(
                "Başlık",
                fontSize: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                  ],
                ),
              ),
              UIHelper.createText(
                "Başlık",
                fontSize: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                  ],
                ),
              ),
              UIHelper.createText(
                "Podcast",
                fontSize: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    UIHelper.createPodcast(),
                    UIHelper.createPodcast(),
                    UIHelper.createPodcast(),
                    UIHelper.createPodcast(),
                    UIHelper.createPodcast(),
                  ],
                ),
              ),
              UIHelper.createText(
                "Başlık",
                fontSize: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                    createCardColumnImageAndText(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  static Widget createHomeScreenContentMusic() {
    return Container(
      color: ColorHelper.shopifyBlack,
      child: GridView.count(
        mainAxisSpacing: 0,
        childAspectRatio: 2,
        crossAxisCount: 1,
        physics: const ClampingScrollPhysics(),
        children: List.generate(30, (index) {
          return createShowCard(IconHelper.likeIcon);
        }),
      ),
    );
  }

  static Widget createHomeScreenContentPodcast() {
    return Container(
      color: ColorHelper.shopifyBlack,
      child: Column(
        children: [
          UIHelper.createCard(
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                      UIHelper.createCard(
                        UIHelper.createImage(width: 70),
                      ),
                    ],
                  ),
                ],
              ),
              color: ColorHelper.shopifyBlack),
          Expanded(
            child: GridView.count(
              // crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 2,
              crossAxisCount: 1,
              physics: const ClampingScrollPhysics(),
              children: List.generate(30, (index) {
                return createShowCard(IconHelper.addCircleIcon);
              }),
            ),
          ),
        ],
      ),
    );
  }

  static Widget createShowCard(IconData icon) {
    return UIHelper.createCard(
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.8, -2.0),
              colors: [
                ColorHelper.shopifyOrange,
                Colors.black54,
              ],
              radius: 1.2,
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: UIHelper.createImage(width: 80),
                      ),
                      UIHelper.createText("Türkçe Pop"),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UIHelper.createTextNoPadding("Çalma listesi", textColor: ColorHelper.shopifyGreyLight, fontSize: 12),
                          UIHelper.createTextNoPadding("Anadolu Rock"),
                          UIHelper.createTextNoPadding(
                            "Barış Manço,Cem Karaca,Erkin Koray,Özdemir Asaf",
                            textColor: ColorHelper.shopifyGreyLight,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [UIHelper.createIcon(icon, () {}), UIHelper.createIcon(IconHelper.menuIcon, () {})],
                  ),
                  Row(
                    children: [UIHelper.createText("50 Şarkı", textColor: ColorHelper.shopifyGreyLight, fontSize: 12), UIHelper.createIcon(IconHelper.play2Icon, () {})],
                  ),
                ],
              ),
            ],
          ),
        ),
        radius: 10);
  }

  static Widget createCardColumnImageAndText() {
    return UIHelper.createCard(
        Column(
          children: [
            UIHelper.createImage(width: 150, image: "assets/images/rush.png"),
            UIHelper.createText("text2"),
          ],
        ),
        color: ColorHelper.shopifyTransparent);
  }

  static Widget createCardImageAndText(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              createCardRowImageAndText("Liked Songs", () {
                RouteHelper.goToScreen(context, const SongScreen());
              }),
              createCardRowImageAndText("Sahip", () {
                RouteHelper.goToScreen(context, const MusicScreen());
              }),
              createCardRowImageAndText("Badem", () {}),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              createCardRowImageAndText("Tekrar Tekrar", () {}),
              createCardRowImageAndText("Mutlu Türkçe Şarkılar", () {}),
              createCardRowImageAndText("ek3-piano", () {}),
            ],
          ),
        ),
      ],
    );
  }

  static Widget createCardRowImageAndText(String text, Function onTap) {
    return InkWell(
        child: UIHelper.createCard(
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              UIHelper.createImage(width: 50),
              Expanded(child: UIHelper.createText(text)),
            ],
          ),
        ),
        onTap: () {
          onTap();
        });
  }
}
