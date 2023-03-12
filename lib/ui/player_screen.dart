import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/ui_helper.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with TickerProviderStateMixin {
  AnimationController? controller;
  IconData icon1 = IconHelper.playIcon;
  bool isIconPlayShown = true;

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller!.duration = const Duration(seconds: 50);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorHelper.shopifyBlack,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _createHeaderWidget(context),
              _createSongImageWidget(),
              _createSongNameWidget(),
              const SizedBox(height: 20),
              const Divider(color: ColorHelper.shopifyWhite, thickness: 2),
              _createSongTimingWidget(),
              _createMusicControlsWidget(),
              _createEnvironmentWidget(),
              _createLyricsWidget()
            ],
          ),
        ),
      ),
    );
  }

  Row _createHeaderWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UIHelper.createIcon(IconHelper.arrowDownIcon, size: 40, padding: const EdgeInsets.all(0), () {
          Navigator.pop(context);
        }),
        Column(
          children: [
            UIHelper.createTextNoPadding("PLAYING", fontSize: 12, fontWeight: FontWeight.normal),
            UIHelper.createTextNoPadding("Happy Songs", fontSize: 12),
          ],
        ),
        UIHelper.createIcon(IconHelper.menuIcon, padding: const EdgeInsets.all(0), () {
          _modalBottomSheetMenu();
        }),
      ],
    );
  }

  Padding _createSongImageWidget() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: UIHelper.createImage(width: 300),
    );
  }

  Row _createSongNameWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.createTextNoPadding("Yıldızların Altında", fontSize: 20),
            UIHelper.createTextNoPadding("KARGO", textColor: ColorHelper.shopifyGreyLight, fontWeight: FontWeight.normal, fontSize: 16),
          ],
        ),
        UIHelper.createIcon(IconHelper.like2Icon, color: ColorHelper.shopifyGreen, padding: const EdgeInsets.all(0), () {}),
      ],
    );
  }

  Row _createSongTimingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UIHelper.createTextNoPadding("0:00", textColor: ColorHelper.shopifyGreyLight),
        UIHelper.createTextNoPadding("3:14", textColor: ColorHelper.shopifyGreyLight),
      ],
    );
  }

  Row _createMusicControlsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UIHelper.createIcon(IconHelper.shuffleIcon, () {}),
        UIHelper.createIcon(IconHelper.backwardIcon, padding: const EdgeInsets.all(0), () {}),
        UIHelper.createCard(
            UIHelper.createIcon(icon1, color: ColorHelper.shopifyBlack, padding: const EdgeInsets.all(20), () {
              setState(() {
                if (isIconPlayShown) {
                  isIconPlayShown = false;
                  icon1 = IconHelper.pauseIcon;
                } else {
                  isIconPlayShown = true;
                  icon1 = IconHelper.playIcon;
                }
              });
            }),
            radius: 50,
            color: ColorHelper.shopifyWhite),
        UIHelper.createIcon(IconHelper.forwardIcon, padding: const EdgeInsets.all(0), () {}),
        UIHelper.createIcon(IconHelper.againIcon, padding: const EdgeInsets.all(0), () {}),
      ],
    );
  }

  Padding _createEnvironmentWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UIHelper.createIcon(IconHelper.deviceIcon, () {}, size: 20, color: ColorHelper.shopifyGreen),
              UIHelper.createTextNoPadding("SOMEONE'S PC", textColor: ColorHelper.shopifyGreen),
            ],
          ),
          Row(
            children: [
              UIHelper.createIcon(IconHelper.shareOutlinedIcon, () {}, size: 20),
              UIHelper.createIcon(IconHelper.menu2Icon, () {}, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  _createLyricsWidget() {
    return UIHelper.createCard(
      SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UIHelper.createTextNoPadding("Lyrics", fontSize: 16),
                    Row(
                      children: [
                        UIHelper.createCard(UIHelper.createIcon(IconHelper.shareOutlinedIcon, () {}, size: 20), radius: 50),
                        UIHelper.createCard(UIHelper.createIcon(IconHelper.fullscreenIcon, () {}, size: 20), radius: 50),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.createTextNoPadding("Lorem ipsum dolor sit amet", fontSize: 20),
                    UIHelper.createTextNoPadding("Nam convallis convallis tortor", fontSize: 20),
                    UIHelper.createTextNoPadding("ut mollis velit", fontSize: 20),
                    UIHelper.createTextNoPadding("Donec eget ex vitae arcu", fontSize: 20),
                    UIHelper.createTextNoPadding("vestibulum congue quis quis tellus", fontSize: 20),
                    UIHelper.createTextNoPadding("In ac nibh at leo aliquet porttitor", fontSize: 20),
                    UIHelper.createTextNoPadding("Praesent ac pretium lacus", fontSize: 20),
                    UIHelper.createTextNoPadding("a laoreet tellus", fontSize: 20),
                    UIHelper.createTextNoPadding("Praesent facilisis malesuada mauris", fontSize: 20),
                    UIHelper.createTextNoPadding("non feugiat", fontSize: 20),
                  ],
                )
              ],
            ),
          )),
      color: ColorHelper.shopifyGreyLight,
    );
  }

  void _modalBottomSheetMenu() {
    controller = BottomSheet.createAnimationController(this);
    controller!.duration = const Duration(milliseconds: 500);
    showModalBottomSheet(
        transitionAnimationController: controller,
        isDismissible: false,
        barrierColor: ColorHelper.shopifyTransparent,
        backgroundColor: ColorHelper.shopifyBlack.withOpacity(0.9),
        // useRootNavigator: true,
        isScrollControlled: true,
        //  enableDrag: false,
        context: context,
        builder: (builder) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
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
                            _createCard(IconHelper.likeIcon, "Beğen", () {}),
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
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  height: 180,
                  color: ColorHelper.shopifyBlack,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            UIHelper.createIcon(IconHelper.shuffleIcon, () {}),
                            UIHelper.createText("Shuffle", fontSize: 12),
                          ],
                        ),
                        Column(
                          children: [
                            UIHelper.createIcon(IconHelper.repeatIcon, () {}),
                            UIHelper.createText("Repeat", fontSize: 12),
                          ],
                        ),
                        Column(
                          children: [
                            UIHelper.createIcon(IconHelper.queueIcon, () {}),
                            UIHelper.createText("Go to Queue", fontSize: 12),
                          ],
                        )
                      ],
                    ),
                  ),
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
          );
        });
  }

  Widget _createCard(IconData icon, String text, Function onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          UIHelper.createIcon(icon, () {
            onTap();
          }, color: ColorHelper.shopifyGreyLight),
          UIHelper.createText(text, fontSize: 16),
        ],
      ),
    );
  }
}
