import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/home_helper.dart';
import 'package:spofity/helper/ui_helper.dart';

class LibraryHelper {
  static Widget createHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {},
              child: UIHelper.createCard(UIHelper.createText("E", fontSize: 20, textColor: ColorHelper.shopifyBlack), color: Colors.pink.shade200, radius: 45),
            ),
            UIHelper.createText("Kitaplığın", fontSize: 20, padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UIHelper.createIcon(IconHelper.search2Icon, () {}),
            UIHelper.createIcon(IconHelper.addIcon, () {}),
          ],
        ),
      ],
    );
  }

  static Widget createHeaderUnder() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: ColorHelper.shopifyBlack,
        child: Row(
          children: [
            UIHelper.createOptions("Çalma Listeleri"),
            UIHelper.createOptions("Postcast'ler ve Programlar"),
            UIHelper.createOptions("Albümler"),
            UIHelper.createOptions("Sanatçılar"),
            UIHelper.createOptions("İndirilenler"),
          ],
        ),
      ),
    );
  }

  static Widget createLibraryScreenContent(
    BuildContext context,
    IconData iconChangeLayout,
    LibraryScreenContentType libraryScreenContentType, {
    required Function onTapList,
    required Function onTapGrid,
  }) {
    return libraryScreenContentType == LibraryScreenContentType.list
        ? LibraryHelper.createLibraryScreenListContent(context, iconChangeLayout, () {
            onTapList();
          })
        : libraryScreenContentType == LibraryScreenContentType.grid
            ? LibraryHelper.createLibraryScreenGridContent(context, iconChangeLayout, () {
                onTapGrid();
              })
            : Container();
  }

  static Widget createLibraryScreen(BuildContext context, IconData icon, Widget gridView, Function onTap) {
    return Container(
      color: ColorHelper.shopifyBlack,
      child: Column(
        children: [
          createIconText(context, icon, () {
            onTap();
          }),
          Expanded(
            child: gridView,
          ),
        ],
      ),
    );
  }

  static Widget createLibraryScreenGridContent(BuildContext context, IconData icon, Function onTap) {
    return createLibraryScreen(
        context,
        icon,
        GridView.count(
          crossAxisSpacing: 0,
          mainAxisSpacing: 40,
          //childAspectRatio: 1.5,
          crossAxisCount: 2,
          physics: const ClampingScrollPhysics(),
          children: List.generate(20, (index) {
            return createCardRowImageAndTextGrid();
          }),
        ),
        onTap);
  }

  static Widget createLibraryScreenListContent(BuildContext context, IconData icon, Function onTap) {
    return createLibraryScreen(
        context,
        icon,
        GridView.count(
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 4,
          crossAxisCount: 1,
          physics: const ClampingScrollPhysics(),
          children: List.generate(20, (index) {
            return createCardRowImageAndTextList();
          }),
        ),
        onTap);
  }

  static Widget createCardRowImageAndTextList() {
    return UIHelper.createCard(
        Row(
          children: [
            UIHelper.createImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.createText("Beğenilen Şarkılar"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UIHelper.createIcon(IconHelper.pinIcon, () {}, color: Colors.green, padding: const EdgeInsets.all(0)),
                    UIHelper.createIcon(IconHelper.downloadIcon, () {}, color: Colors.green, padding: const EdgeInsets.all(0)),
                    UIHelper.createText("Çalma Listesi *Spotify", textColor: ColorHelper.shopifyGreyLight, padding: const EdgeInsets.all(4))
                  ],
                ),
              ],
            ),
          ],
        ),
        color: ColorHelper.shopifyBlack);
  }

  static Widget createCardRowImageAndTextGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UIHelper.createImage(width: 150),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.createTextNoPadding("Beğenilen Şarkılar"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.createIcon(IconHelper.pinIcon, () {}, color: Colors.green, padding: const EdgeInsets.all(0), size: 20),
                  UIHelper.createIcon(IconHelper.downloadIcon, () {}, color: Colors.green, padding: const EdgeInsets.all(0), size: 20),
                  UIHelper.createText("Çalma Listesi", textColor: ColorHelper.shopifyGreyLight, padding: const EdgeInsets.all(0))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  static Widget createIconText(BuildContext context, IconData icon, Function onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            UIHelper.createIcon(IconHelper.upDownArrowIcon, () {}, size: 20),
            InkWell(
              onTap: () {
                modalBottomSheetMenu(context);
              },
              child: UIHelper.createText("Son Çalınanlar", fontSize: 12),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UIHelper.createIcon(icon, () {
              onTap();
            }, size: 20),
          ],
        )
      ],
    );
  }

  static void modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        barrierColor: ColorHelper.shopifyTransparent,
        backgroundColor: ColorHelper.shopifyGreyDark,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 30),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              UIHelper.createText(
                "Şuna göre sırala:",
                fontSize: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UIHelper.createText("Son çalınanlar", textColor: ColorHelper.shopifyGreen),
                  UIHelper.createIcon(IconHelper.checkMarkIcon, () {}, color: ColorHelper.shopifyGreen),
                ],
              ),
              UIHelper.createText("Yeni eklenenler"),
              UIHelper.createText("Alfabetik"),
              UIHelper.createText("Oluşturan"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIHelper.createText("İPTAL", textColor: ColorHelper.shopifyGreyLight),
                ],
              )
            ]),
          );
        });
  }
}
