// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_employee/Models/auth/app_local.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constant.dart';
import '../Authentication/select_type.dart';
import '../Authentication/sign_in.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  String buttonText = 'Next';
  double percent = 0.5;

  /// conditoin next slider and goto next scereen
  bool isCompleteSlider = false;

  List<Map<String, dynamic>> sliderList = [
    // {
    //   "icon": 'images/onboard1.png',
    //   "title": 'Keep healthy work-life balance',
    //   "description":
    //       'Lorem ipsum dolor sit amet, consectetuer adipisci elit, sed diam nonummy nibh euismod tincidunt u laoreet dolore magna aliquam erat volutpat. Ut wi',
    // },
    {
      "icon": 'images/onboard2.png',
      "title": 'Track your work & get result',
      "description":
          'Effortlessly monitor your progress and achieve results with a streamlined work tracking system.',
    },
    {
      "icon": 'images/onboard3.png',
      "title": 'Stay organized with team',
      "description":
          'Keep your HR team organized and coordinated to manage tasks and track progress effectively.',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDFF),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFFCF1F0)),
        backgroundColor: const Color(0xFFF0FDFF),
        elevation: 0.0,
        actions: [
          const SizedBox(
            width: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: () {
                _onBoardClose();

                /// sign-in page
                const SignIn().launch(context, isNewTask: true);
              },
              child: const Text(
                'Skip',
                // style: GoogleFonts.dmSans(
                //   fontSize: 16.0,
                //   color: kTitleColor,
                // ),

                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: kTitleColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30.0,
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: context.height() - 100,
              width: context.width(),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: sliderList.length,
                    controller: pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        /*
                        switch (index) {
                          case 0:
                            {
                              percent = 0.33;
                              currentIndexPage = 0;
                            }
                            break;
                          case 1:
                            {
                              percent = 0.66;
                              currentIndexPage = 1;
                            }
                            break;
                          case 2:
                            {
                              percent = 1.00;
                              currentIndexPage = 2;
                            }
                            break;
                        }
                        */

                        switch (index) {
                          case 0:
                            {
                              percent = 0.50;
                              currentIndexPage = 0;
                            }
                            break;
                          case 1:
                            {
                              percent = 1;
                              currentIndexPage = 1;
                            }
                            break;
                        }
                      });
                    },
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Image.asset(
                            sliderList[index]['icon'],
                            fit: BoxFit.fill,
                            width: context.width(),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 30.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                    child: Text(
                                      sliderList[index]['title'].toString(),
                                      textAlign: TextAlign.start,
                                      style: kTextStyle.copyWith(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    // ignore: sized_box_for_whitespace
                                    child: Container(
                                      width: context.width(),
                                      child: Text(
                                        sliderList[index]['description']
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        style: kTextStyle.copyWith(
                                          fontSize: 15.0,
                                          color: kGreyTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ignore: sized_box_for_whitespace
                        ],
                      );
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DotIndicator(
                          currentDotSize: 15,
                          dotSize: 6,
                          pageController: pageController,
                          pages: sliderList,
                          indicatorColor: kMainColor,
                          unselectedIndicatorColor: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          radius: 80.0,
                          lineWidth: 3.0,
                          progressColor: kMainColor,
                          percent: percent,
                          animation: true,
                          center: GestureDetector(
                            onTap: () {
                              if (currentIndexPage < 1) {
                                setState(() {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(microseconds: 3000),
                                      curve: Curves.bounceInOut);
                                });
                              } else {
                                _onBoardClose();

                                /// sign-in page
                                const SignIn().launch(context, isNewTask: true);
                              }

                              /*
                              setState(() {
                                currentIndexPage < 2
                                    ? pageController.nextPage(
                                        duration:
                                            const Duration(microseconds: 3000),
                                        curve: Curves.bounceInOut)
                                    : () {
                                        _onBoardClose();

                                        /// sign-in page
                                        const SignIn()
                                            .launch(context, isNewTask: true);
                                      };
                              });
                            */
                              /// Default goto select type
                              /*
                              setState(() {
                                currentIndexPage < 2
                                    ? pageController.nextPage(
                                        duration:
                                            const Duration(microseconds: 3000),
                                        curve: Curves.bounceInOut)
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SelectType()),
                                      );
                              });
                              */
                            },
                            child: const CircleAvatar(
                              radius: 35.0,
                              backgroundColor: kMainColor,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBoardClose() {
    /// Update onBoardClose.
    AppLocal appLocal = AppServices.instance<DatabaseService>().getAppLocal!;
    appLocal.isOnboardClose = true;
    AppServices.instance<DatabaseService>().putAppLocal(appLocal);
  }
}
