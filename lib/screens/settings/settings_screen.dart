import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pharaohs_gold_app/router/router.dart';
import 'package:pharaohs_gold_app/theme/colors.dart';
import 'package:pharaohs_gold_app/widgets/action_button_widget.dart';
import 'package:pharaohs_gold_app/widgets/back_button_widget.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.gradientBackground,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonWidget(onTap: () {
                      context.router.popAndPush(HomeRoute());
                    }),
                    Text(
                      'Settings'.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.lightBrown,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto Serif'),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
                Column(
                  children: [
                    ActionButtonWidget(
                        onTap: () {
                          Share.share('Check out The Pharaons Ancient Gold');
                        },
                        verticalPadding: 12,
                        horizontalPadding: 45,
                        text: 'Share with friends',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    SizedBox(height: 15),
                    ActionButtonWidget(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Pharaons(
                                data:
                                    'https://docs.google.com/document/d/1fL4_PoaixsFnpqv-sEon3vJC64PDYC-PeGFclp41ad4/edit?usp=sharing'),
                          ));
                        },
                        verticalPadding: 12,
                        horizontalPadding: 60,
                        text: 'Privacy Policy',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    SizedBox(height: 15),
                    ActionButtonWidget(
                        onTap: () {
                           Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Pharaons(
                                data:
                                    'https://docs.google.com/document/d/1jQ7HSzNYkAoGpGnU6RJQMlZKVY5HWKtL6G57xHYSMpc/edit?usp=sharing'),
                          ));
                        },
                        verticalPadding: 12,
                        horizontalPadding: 64,
                        text: 'Terms of use',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Pharaons extends StatefulWidget {
  const Pharaons({super.key, required this.data});
  final String data;

  @override
  State<Pharaons> createState() => _PharaonsState();
}

class _PharaonsState extends State<Pharaons> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 148, 133, 5),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.data),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
