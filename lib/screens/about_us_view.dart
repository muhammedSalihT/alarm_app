import 'package:alarm_app/constents/app_colors.dart';
import 'package:alarm_app/screens/help_and_support_view.dart';
import 'package:alarm_app/utils/app_navigation.dart';
import 'package:alarm_app/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.push(
          context: context, materialRoutePage: const ContactUsView()),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: const RefractedTextWidget(text: 'About Us'),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: RefractedTextWidget(
                  align: TextAlign.start,
                  maxLines: 200,
                  text:
                      '''Lörem ipsum fädide krov åsk nätdeklarant mir. Tetravis. San sar teska pertotal. Kvasin växtmjölk lähäde sefäpp. Satonera antining pande kament. Tekont bir intrafäde, om jågon pronde. Betest nånannanism och dungar teläheten ultraskade. Carpa sudoku ifall fasm yns. Vydil läktig. Dunera teraktig: samt tod i prevödat ifall ekokrati. 
            Reläre viv ist, makonde om pogisk. Treling dåska malysk, för ninade. Hypodubibel fäponing. Synigt epiosmos och prespehet SMS-meddelande yspena. Lagen infravis ljudöra. 
            Ar poheten: ar. Makrorelyning. Tinira nens. Pren religt. Vöngar kontrast tritesm. 
            Pregisk nyment har svennefiera. Dekabel flitbonus syngam gigasen prer. Selogi kvasiaktiv utom sost. Preska trerad i renade infralägt. Krobusonat kament. 
            Koka böcker operalog. Netrerepp misocentrism tede durtad att detris. Pebyd. Astrore neniv ten. Temakonfirmation pår inte paprede för ultravypladide popasat. 
            Vösk besam, buvis: i lyvore, i exogöns. Glokal koren prenat. Nisade tirat. Aling nesk sybupp trafficking vaska. Sar växtbaserat kött. 
            Planade syssna som toren. Nesoskap öläng. Manat platenat. Intralagon fashionista monoparat har delig. Kror popcornhjärna dyrenade lårskav heterons. 
            ''',
                  textSize: 20,
                  textColor: AppColors.appGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
