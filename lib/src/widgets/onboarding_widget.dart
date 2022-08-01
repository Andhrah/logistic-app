class OnboardingWidget {
  String image;
  String title;
  String description;

  OnboardingWidget(
      {required this.image, required this.title, required this.description});
}

class OnboardingList {
  late List<OnboardingWidget> _list;
  List<OnboardingWidget> get list => _list;

  OnboardingList() {
    _list = [
      OnboardingWidget(
        image: 'assets/images/onboarding_img1.png',
        title: 'Choose location',
        description: 'Choose your pickup and delivery location?',
      ),
      OnboardingWidget(
        image: 'assets/images/onboarding_img2.png',
        title: 'Choose your preferred ride',
        description: 'Accept the proposed ride of choose your preferred ride',
      ),
      OnboardingWidget(
        image: 'assets/images/onboarding_img3.png',
        title: 'Checkout and Make payment',
        description:
            'Pay with zebrra and get 20% off or choose preferred payment method',
      ),
      OnboardingWidget(
        image: 'assets/images/onboarding_img4.png',
        title: 'Receive your item',
        description:
            'Receive your delivery and notify that your item has been received',
      ),
    ];
  }
}
