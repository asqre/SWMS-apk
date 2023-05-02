import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swms/screen/login_signup/sign_up_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 64,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30), //TODO
            child: Text(
              subtitle,
              style: const TextStyle(color: Colors.black,),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = (index == 2);
            });
          },
          children: [
            // Container(
            //   color: Colors.red,
            //   child: const Center(child:Text('Page 1'),),
            // ),
            // Container(
            //   color: Colors.indigo,
            //   child: const Center(child:Text('Page 2'),),
            // ),
            // Container(
            //   color: Colors.green,
            //   child: const Center(child:Text('Page 3'),),
            // )
            buildPage(
              color: Colors.green.shade100,
              urlImage: 'assets/images/reduce.jpg',
              title: 'REDUCE',
              subtitle: 'Revolutionizing Waste Reduction through Innovative\n               Technology and Sustainable Practices.',
            ),
            buildPage(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/reuse.jpg',
              title: 'REUSE',
              subtitle: 'Revolutionizing waste management through sustainable\n                       and efficient reuse strategies.',
            ),
            buildPage(
              color: Colors.orange.shade100,
              urlImage: 'assets/images/recycle.jpg',
              title: 'RECYCLE',
              subtitle: 'Revolutionizing waste reduction through intelligent\n                           recycling technology.',
            )
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal.shade700,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () async {
                //navigate directly to homepage
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 24),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: const Text('SKIP')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                      child: const Text('NEXT')),
                ],
              ),
            ),
    );
  }
}
