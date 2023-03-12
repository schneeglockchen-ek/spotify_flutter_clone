import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/route_helper.dart';
import 'package:spofity/helper/ui_helper.dart';
import 'package:spofity/ui/main_screen.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool isVisibleAlbumCover = true;
  double currentHeight = -1;
  double previousHeight = 0;
  IconData iconPlay = IconHelper.playIcon;
  ScrollController scrollController = ScrollController();
  HomeScreenType selectedScreenIndex = HomeScreenType.home;
  static bool isIconPlayShown = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
      toolbarHeight: 85,
      leadingWidth: 200,
      leading: _createLeading(context),
      expandedHeight: 310,
      statusBarHeight: 100,
      isCollapsed: (double height) async {
        _isCollapsed(height);
      },
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
          isVisibleAlbumCover = height > 150;
        });
      }
    }
  }

  Row _createLeading(BuildContext context) {
    return Row(
      children: [
        UIHelper.createIcon(
          IconHelper.arrowLeftIcon,
          () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.only(left: 0),
        ),
        Visibility(
          visible: !isVisibleAlbumCover,
          child: UIHelper.createText("Sahip", fontSize: 20, padding: const EdgeInsets.only(left: 20)),
        )
      ],
    );
  }

  Stack _createAltWidget2() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        UIHelper.createIcon(IconHelper.play2Icon, () {}, size: 35, color: ColorHelper.shopifyGreen),
        Container(
          color: ColorHelper.shopifyBlack,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.createText("Sahip", fontSize: 20),
              UIHelper.createText("Kurban", fontSize: 14),
              UIHelper.createText("Albüm * 2020", fontSize: 14, textColor: Colors.grey.shade700),
              _createOptions(),
              //  _buildActions(),
              Expanded(
                child: GridView.count(
                  // crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 4,
                  crossAxisCount: 1,
                  physics: const ClampingScrollPhysics(),
                  children: List.generate(30, (index) {
                    return _createCardRowImageAndText();
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Visibility _createHeaderUnder() {
    return Visibility(
      visible: isVisibleAlbumCover,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: UIHelper.createImage(width: 250),
      ),
    );
  }

  Container _createHeader() => Container();

  showProfile() {
    Navigator.pushNamed(context, '/profile');
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
                UIHelper.createText("Beğenilen Şarkılar"),
                UIHelper.createText("Çalma Listesi *Spotify", textColor: ColorHelper.shopifyGreyLight),
              ],
            ),
            Column(
              children: [UIHelper.createIcon(IconHelper.menuIcon, () {})],
            )
          ],
        ),
        color: ColorHelper.shopifyBlack);
  }

  Widget _createOptions() {
    return Row(
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
            UIHelper.createIcon(IconHelper.shuffleIcon, () {}, color: ColorHelper.shopifyGreyLight),
            UIHelper.createIcon(IconHelper.play2Icon, () {}, size: 35, color: ColorHelper.shopifyGreen),
          ],
        )
      ],
    );
  }
}
