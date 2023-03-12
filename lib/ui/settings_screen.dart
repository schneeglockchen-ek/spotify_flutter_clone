import 'package:flutter/material.dart';
import 'package:spofity/const/color_helper.dart';
import 'package:spofity/const/icon_helper.dart';
import 'package:spofity/helper/route_helper.dart';
import 'package:spofity/helper/ui_helper.dart';
import 'package:spofity/ui/main_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool valueSesKalitesi = true;
  bool valueSesIndir = true;
  bool valueSesDinle = true;
  bool valueCevrimdisi = true;
  bool valueAraliksizCal = true;
  bool valueOtomatikGecis = true;
  bool valueSansursuz = true;
  bool valueCalinamayanSarki = true;
  bool valueSesDuzeyi = true;
  bool valueMonoSes = true;
  bool valueCihazyayini = true;
  bool valueOtomatikCalma = true;
  bool valueYerelCihazGoster = true;
  bool valueSpotifyConnect = true;
  bool valueGizliOturum = true;
  bool valueDinlemeEtkinligi = true;
  bool valueEnsonCalinanlar = true;
  bool valueKaliteyiOtomatikAyarla = true;
  bool valueHucreselSebeke = true;
  bool valueSesDosyalariniGoster = true;
  IconData iconPlay = IconHelper.playIcon;
  HomeScreenType selectedScreenIndex = HomeScreenType.home;
  static bool isIconPlayShown = true;

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
      leading: _createLeading(context),
      expandedHeight: 0,
      statusBarHeight: 70,
    );
  }

  Column _createHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _createHeaderUnder(),
        Container(
          child: UIHelper.createText(
            "Ayarlar",
            fontSize: 20,
            padding: const EdgeInsets.only(top: 30),
          ),
        ),
      ],
    );
  }

  Container _createHeaderUnder() => Container();

  Container _createAltWidget2() {
    return Container(
      color: ColorHelper.shopifyBlack,
      child: _createList(),
    );
  }

  _createLeading(BuildContext context) {
    UIHelper.createIcon(
      IconHelper.arrowLeftIcon,
      () {
        Navigator.pop(context);
      },
    );
  }

  Widget _container(Widget widget, {Function? onTap}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          color: ColorHelper.shopifyBlack,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: widget,
        ),
      ),
      onTap: () {
        onTap!();
      },
    );
  }

  Widget _textAnaBaslik(String textAnaBaslik) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: UIHelper.createTextNoPadding(textAnaBaslik, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _textBaslik(String textBaslik) {
    return UIHelper.createTextNoPadding(textBaslik);
  }

  Widget _textAciklama(String textAciklama) {
    return UIHelper.createTextNoPadding(textAciklama, fontSize: 12, textColor: ColorHelper.shopifyGreyLight);
  }

  Widget _createList() {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        UIHelper.createCard(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UIHelper.createCard(
                      UIHelper.createText("E", fontSize: 20, fontWeight: FontWeight.bold, textColor: ColorHelper.shopifyBlack),
                      color: ColorHelper.shopifyPink,
                      radius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _textAnaBaslik("ee"),
                          _textAciklama("Planını görüntüle"),
                        ],
                      ),
                    )
                  ],
                ),
                UIHelper.createIcon(IconHelper.rightArrowIcon, () {}),
              ],
            ),
            color: ColorHelper.shopifyBlack),
        _textAnaBaslik("Hesap"),
        _container(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textBaslik("Premium planı"),
            _textAciklama("Planını görüntüle"),
          ],
        )),
        _container(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _textBaslik("E-posta"),
          _textAciklama("email@email.com"),
        ])),
        _textAnaBaslik("Veri Tasarrufu"),
        _container(_switchContainer(
          "Ses Kalitesi",
          "Ses Kalitesini düşük (24 kbit/s ile eşdeğer) olarak ayarlar ve sanatçı Canvas'larını devre dışı bırakır.",
          valueSesKalitesi,
          (bool newValue) {
            setState(() {
              valueSesKalitesi = newValue;
            });
          },
        )),
        _textAnaBaslik("Video Podcast'ler"),
        _container(
          _switchContainer(
            "Yalnızca sesi indir",
            "Video podcast'leri yalnızca ses olarak kaydet.",
            valueSesIndir,
            (bool newValue) {
              setState(() {
                valueSesIndir = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Yalnızca sesi dinle",
            "Wi-Fi'ye bağlı olmadığında video podcast'leri yalnızca ses olarak çal. ",
            valueSesDinle,
            (bool newValue) {
              setState(() {
                valueSesDinle = newValue;
              });
            },
          ),
        ),
        _container(
          Row(
            children: [
              UIHelper.createIcon(IconHelper.infoIcon, () {}),
              Expanded(child: _textAciklama("Not:Spotify uygulaması arka planda çalışırken video oynatılma.")),
            ],
          ),
        ),
        _textAnaBaslik("Çal(Şimdi Kullanılamaz)"),
        _container(
          _switchContainer(
            "Çevrimdışı modu",
            "Çevrimdışı olduğunda yalnızca indirdiğin müzikleri ve podcast'leri dinleyebileceksin.",
            valueCevrimdisi,
            (bool newValue) {
              setState(() {
                valueCevrimdisi = newValue;
              });
            },
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_textBaslik("Çapraz geçiş"), _textAciklama("Şarkılar arasında çapraz geçiş sağlar.")],
          ),
        ),
        _textAciklama("Kapalı"),
        _container(
          _switchContainer(
            "Aralıksız",
            "Aralıksız çalmaya izin verir.",
            valueAraliksizCal,
            (bool newValue) {
              setState(() {
                valueAraliksizCal = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Otomatik geçiş",
            "Belirli çalma listelerinde, şarkılar arasında kesintisiz geçişlere izin verir.",
            valueOtomatikGecis,
            (bool newValue) {
              setState(() {
                valueOtomatikGecis = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Sansürsüz İçeriğe İzin Ver",
            "Sansürsüz içerik çalmak için aç\nSansürsüz içerik E etiketiyle işaretlendi",
            valueSansursuz,
            (bool newValue) {
              setState(() {
                valueSansursuz = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Çalınamayan şarkıları göster",
            "Çalınabilir olmayan şarkıları göster.",
            valueCalinamayanSarki,
            (bool newValue) {
              setState(() {
                valueCalinamayanSarki = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Ses düzeyini normalize et",
            "Tüm parçalar için aynı se seviyesini kullan",
            valueSesDuzeyi,
            (bool newValue) {
              setState(() {
                valueSesDuzeyi = newValue;
              });
            },
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Ses seviyesi"),
              _textAciklama("Bulunduğun ortama göre ses seviyesini ayarla.Yüksek sesli seçeneğinde ses kalitesi düşebilir.Normal veya Sessiz seçildiğinde ses kalitesi etkilenmez")
            ],
          ),
        ),
        _container(
          _switchContainer(
            "Mono Ses",
            "Sol ve sağ hoparlörlerde aynı sesi çalar",
            valueMonoSes,
            (bool newValue) {
              setState(() {
                valueMonoSes = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Cihaz Yayını Durumu",
            "Cihazındaki diğer uyg.ne dinlediğini göstermesine izi ver.",
            valueCihazyayini,
            (bool newValue) {
              setState(() {
                valueCihazyayini = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Otomatik Çalma",
            "Kesintisiz dinlemenin tadını çıkar.Dinlediğin içerik sona erdiğinde benzerelerini çalarız.",
            valueOtomatikCalma,
            (bool newValue) {
              setState(() {
                valueOtomatikCalma = newValue;
              });
            },
          ),
        ),
        _textAnaBaslik("Cihazlar"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_textBaslik("Bir cihaza bağlan"), _textAciklama("Spotify'ı cihazlarında dinle ve kontrol et. ")],
          ),
        ),
        _container(
          _switchContainer(
            "Sadece yerel cihazları göster",
            "Cihazlar menüsünde sadece yerel Wi-Fi veya ethernet ağında olanları göster.",
            valueYerelCihazGoster,
            (bool newValue) {
              setState(() {
                valueYerelCihazGoster = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Spotify Connect Arka Planda",
            "Uygulama arka plandayken,Spotify Connect'in Spotify'ı çalışır durumda tutmasına izin ver.",
            valueSpotifyConnect,
            (bool newValue) {
              setState(() {
                valueSpotifyConnect = newValue;
              });
            },
          ),
        ),
        _textAnaBaslik("Sesli Asistanlar ve Uygulamalar"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_textBaslik("Gezinme ve Diğer Uygulamalar"), _textAciklama("Dinleme deneyimini daha iyi hale getirmek için gezinme ve diğer uygulamalara bağlan. ")],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_textBaslik("Araba"), _textAciklama("Herzaman yola dikkat et ve tüm trafik kurallarına uy. ")],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_textBaslik("Car Thing"), _textAciklama("Car Thing'ini ayarla ve yönet. ")],
          ),
        ),
        _textAnaBaslik("Sosyal(Şimdi Kullanılamaz)"),
        _container(
          _switchContainer(
            "Gizli oturum",
            "İsmin görünmeden dinlemek için gizli oturum başlat.",
            valueGizliOturum,
            (bool newValue) {
              setState(() {
                valueGizliOturum = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Dinleme etkinliği",
            "Dinlediklerimi Spotify'da takipçilerimle paylaş.",
            valueDinlemeEtkinligi,
            (bool newValue) {
              setState(() {
                valueDinlemeEtkinligi = newValue;
              });
            },
          ),
        ),
        _container(
          _switchContainer(
            "Enson çalınan sanatçılar",
            "Enson çaldığım sanatçıları herekese açık profilimde göster.",
            valueEnsonCalinanlar,
            (bool newValue) {
              setState(() {
                valueEnsonCalinanlar = newValue;
              });
            },
          ),
        ),
        _textAnaBaslik("Ses Kalitesi(Şimdi Kullanılamaz)"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_textBaslik("Wi-Fi ile çalarken"), _textAciklama("Veri tasarrufu açık olduğunda bu ayarı değiştiremezsin")],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Mobil ile çalarken"),
              _textAciklama("Veri tasarrufu açık olduğunda bu ayarı değiştiremezsin"),
            ],
          ),
        ),
        _container(
          _switchContainer(
            "Kaliteyi otomatik ayarla",
            "Önerilen ayar:Açık\nİnternetinin bant genişliği düşük olduğunda ses kaliteni buna göre ayarlarız.Bu ayarı kapattığında dinleme deneyiminde kesintiler yaşayabilirsin.",
            valueKaliteyiOtomatikAyarla,
            (bool newValue) {
              setState(() {
                valueKaliteyiOtomatikAyarla = newValue;
              });
            },
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("İndir"),
              _textAciklama("Daha yüksek kalite, daha çok alan kullanılır."),
            ],
          ),
        ),
        _container(
          _switchContainer(
            "Hücresel şebeke kullanarak indir",
            "Önerilen ayar:Kapalı",
            valueHucreselSebeke,
            (bool newValue) {
              setState(() {
                valueHucreselSebeke = newValue;
              });
            },
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_textBaslik("Ekolayzer"), _textAciklama("Ekolayzer denetim masasını aç.")],
          ),
        ),
        _textAnaBaslik("Video Kalitesi(Şimdi Kullanılamaz)"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Wi-Fi ile çalarken"),
              _textAciklama(""),
            ],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Mobil ile çalarken"),
              _textAciklama("Hücresel bağlantı ile daha yüksek kalitede çaldığında daha fazla veri kullanılır."),
            ],
          ),
        ),
        _textAnaBaslik("Depolama"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("İndirilenlerin tümünü kaldır"),
              _textAciklama("Çevrimdışı kullanmak üzere indirdiğin tüm Spotify içerikleri kaldırılır."),
            ],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Önbelleği temizle"),
              _textAciklama("Önbelleğini temizleyerek depolama alanı açabilirisin.İndirdiğin içerikler kaldırılamaz."),
            ],
          ),
        ),
        _textAnaBaslik("Bildirimler"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Bildirimler"),
              _textAciklama("Hangi bildirimleri almak istediğini seç."),
            ],
          ),
        ),
        _textAnaBaslik("Yerel Dosyalar"),
        _container(
          _switchContainer(
            "Bu cihazdaki ses dosyalarını göster",
            "Bu cihazdaki parçaları Kitaplığın'a ekler.",
            valueSesDosyalariniGoster,
            (bool newValue) {
              setState(() {
                valueSesDosyalariniGoster = newValue;
              });
            },
          ),
        ),
        _textAnaBaslik("Hakkında"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Sürüm"),
              _textAciklama("8.8.0.347"),
            ],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Üçüncü taraf yazılım"),
              _textAciklama("Süper yazılım,bize yardımcı oldu."),
            ],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Bildirimler"),
              _textAciklama("Hangi bildirimleri almak istediğini seç."),
            ],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Şart ve Koşullar"),
              _textAciklama("Bilmen gereken herşey."),
            ],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Gizlilik Politikası"),
              _textAciklama("İkimiz için de önemli."),
            ],
          ),
        ),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Destek"),
              _textAciklama("Bizden ve topluluktan yardım al."),
            ],
          ),
        ),
        _textAnaBaslik("Diğer"),
        _container(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik("Oturumu Kapat"),
              _textAciklama("ee olarak oturum açtın."),
            ],
          ),
        ),
      ],
    );
  }

  Widget _switchContainer(String baslik, String aciklama, bool initialValue, Function onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textBaslik(baslik),
              _textAciklama(aciklama),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _createSwitch(
                initialValue,
                onChanged,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _createSwitch(bool value, Function onChanged) {
    return Switch(
      value: value,
      activeColor: ColorHelper.shopifyRed,
      inactiveThumbColor: ColorHelper.shopifyWhite,
      inactiveTrackColor: ColorHelper.shopifyGreyLight,
      onChanged: (bool newValue) {
        onChanged(newValue);
      },
    );
  }
}
