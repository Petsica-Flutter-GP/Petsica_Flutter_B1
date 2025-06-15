import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/core/utils/app_router.dart';
import 'package:petsica/core/utils/styles.dart';
import 'package:petsica/features/onboarding/presentation/views/widgets/loading_image.dart';

class OnboardingBody {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnboardingBody({
    required this.title,
    required this.description,
    required this.image,
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
  });
}

class OnboardingPage extends StatefulWidget {
  final List<OnboardingBody> pages;

  const OnboardingPage({super.key, required this.pages});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              // ✅ زر Skip في أعلى اليمين
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      context.go(AppRouter.kWelcomeBack);
                    },
                    child: Text(
                      "Skip",
                      style: Styles.textStyleQui20.copyWith(
                        color: kBurgColor,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ImageWithLoading(imagePath: item.image),
                          ),
                          // const SizedBox(height: 20),
                          Text(
                            item.title,
                            style: Styles.textStyleQu28
                                .copyWith(color: item.textColor, fontSize: 32),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8.0),
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                              style: Styles.textStyleCom18.copyWith(
                                  color: item.textColor, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // ✅ مؤشر الصفحات
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages.map((item) {
                  int index = widget.pages.indexOf(item);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? kBurgColor
                          : kBurgColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  );
                }).toList(),
              ),

              // ✅ أزرار التنقل
              SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ✅ زر الرجوع "Back"
                      if (_currentPage > 0) // إخفاء الزر في الصفحة الأولى
                        TextButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOutCubic,
                            );
                          },
                          child: Text(
                            "Back",
                            style: Styles.textStyleQui20.copyWith(
                              color: kBurgColor,
                            ),
                          ),
                        )
                      else
                        const SizedBox(), // عنصر فارغ عند الصفحة الأولى

                      // ✅ زر التالي / إنهاء
                      TextButton(
                        onPressed: () {
                          if (_currentPage == widget.pages.length - 1) {
                            context.go(AppRouter.kWelcomeBack);
                          } else {
                            _pageController.animateToPage(
                              _currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250),
                            );
                          }
                        },
                        child: Text(
                          _currentPage == widget.pages.length - 1
                              ? "Finish"
                              : "Next",
                          style: Styles.textStyleQui20.copyWith(
                            color: kBurgColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
