import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tramber/View/modules/user/intro_pages/admin_or-user.dart';


import 'pageview_tabs/view1.dart';
import 'pageview_tabs/view2.dart';
import 'pageview_tabs/view3.dart';

class page_view extends StatelessWidget {
  PageController controller = PageController(initialPage: 1);
  final List<Widget> pages = [
    const View1(),
    const View2(),
    const View3(),
  ];

  page_view({super.key});

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: hight,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: hight * .8,
              width: width,
              child: PageView(
                controller: controller,
                children: pages,
              ),
            ),
            SmoothPageIndicator(
                controller: controller, // PageController
                count: 3,
                effect: const WormEffect(),
                // forcing the indicator to use a specific direction
                textDirection: TextDirection.ltr),
            Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AdminOrUserPage()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                alignment: Alignment.center,
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(60)),
                child: const Text(
                  "GET STARTED",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
