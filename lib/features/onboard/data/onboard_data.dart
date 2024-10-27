import '../../../generated/assets.dart';

class OnboardingData {
  final String title;
  final String desc;
  final String image;

  const OnboardingData({
    required this.title,
    required this.desc,
    required this.image,
  });
}

const List<OnboardingData> onboardData = [
  OnboardingData(
    title: 'Your Ingredients Your Recipes',
    desc: 'Discover how easy it is to cook delicious meals with what you already have at home',
    image: Assets.imagesOnboard1,
  ),
  OnboardingData(
    title: 'Save Your\nFavorites',
    desc: 'Keep track of recipes you love by adding them to your favorites. Never lose a great recipe again!',
    image: Assets.imagesOnboard2,
  ),
  OnboardingData(
    title: 'Need More Ingredients?',
    desc: 'Easily add missing ingredients to your shopping list with just a tap',
    image: Assets.imagesOnboard4,
  ),
];