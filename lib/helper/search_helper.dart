import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/ui_helper.dart';

class SearchHelper {
  static Widget createSearchHeader() {
    return UIHelper.createText("Ara", fontSize: 20, padding: const EdgeInsets.only(top: 80));
  }

  static Widget createSearchField() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SizedBox(
        height: 60,
        child: UIHelper.createCard(
            Row(
              children: [
                UIHelper.createIcon(IconHelper.search2Icon, () {}, color: ColorHelper.shopifyBlack),
                UIHelper.createText(
                  "Ne Dinlemek istiyorsun?",
                  fontSize: 20,
                  textColor: Colors.black54,
                )
              ],
            ),
            radius: 5,
            color: ColorHelper.shopifyWhite),
      ),
    );
  }

  static Widget createSearchScreenContent(BuildContext context) {
    return Container(
        color: ColorHelper.shopifyBlack,
        child: Column(
          children: [
            UIHelper.createText("Hepsine göz at", fontSize: 20, padding: const EdgeInsets.only(top: 35, bottom: 15)),
            Expanded(
              child: SizedBox(
                height: 800, //todo ekran yukseklıgı - appbar yukselıgı
                child: GridView.count(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                    children: List.generate(30, (index) {
                      return SearchHelper.createCard(context, "text", Color(0xFF7722cc + (index * 7000)));
                    })
                    // _createCard((i++).toString()),],
                    ),
              ),
            ),
          ],
        ));
  }

  static Widget createCard(BuildContext context, String a, Color color) {
    return UIHelper.createCard(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UIHelper.createText("2023 $a"),
            Transform.rotate(
              angle: pi / 5,
              origin: const Offset(-20, 9),
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorHelper.shopifyBlack,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: UIHelper.createImage(width: 50),
              ),
            ),
          ],
        ),
        color: color);
  }
}
