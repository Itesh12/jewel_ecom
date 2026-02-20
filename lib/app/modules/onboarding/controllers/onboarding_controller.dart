import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/navigation_service.dart';

class OnboardingController extends GetxController {
  final _navService = Get.find<NavigationService>();
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingSlideData> slides = [
    OnboardingSlideData(
      title: "Discover\nTimeless Elegance",
      subtitle:
          "Explore our exclusive collection of premium jewelry tailored just for you.",
      image:
          "assets/images/onboarding_1.png", // Fallback to icons/gradients in view
    ),
    OnboardingSlideData(
      title: "Crafted with\nPrecision",
      subtitle:
          "Every piece is a masterpiece, designed to celebrate your unique story.",
      image: "assets/images/onboarding_2.png",
    ),
    OnboardingSlideData(
      title: "Luxury\nAt Your Doorstep",
      subtitle:
          "Experience seamless shopping and worldwide shipping with just a tap.",
      image: "assets/images/onboarding_3.png",
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void next() {
    if (currentPage.value < slides.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      getStarted();
    }
  }

  void skip() {
    getStarted();
  }

  void getStarted() {
    _navService.toLogin();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingSlideData {
  final String title;
  final String subtitle;
  final String image;

  OnboardingSlideData({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}
