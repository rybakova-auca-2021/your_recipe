import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/l10n/messages_en.dart';
import '../../../core/l10n/messages_ru.dart';
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

List<OnboardingData> getOnboardingData(BuildContext context) {
  Locale currentLocale = Localizations.localeOf(context);
  bool isRussian = currentLocale.languageCode == 'ru';

  return [
    OnboardingData(
      title: isRussian ? messagesRu['onboarding_title_1'] ?? 'Default Title 1' : messagesEn['onboarding_title_1'] ?? 'Your Ingredients Your Recipes',
      desc: isRussian ? messagesRu['onboarding_desc_1'] ?? 'Default Description 1' : messagesEn['onboarding_desc_1'] ?? 'Discover how easy it is to cook delicious meals with what you already have at home',
      image: Assets.imagesOnboard1,
    ),
    OnboardingData(
      title: isRussian ? messagesRu['onboarding_title_2'] ?? 'Default Title 2' : messagesEn['onboarding_title_2'] ?? 'Save Your\nFavorites',
      desc: isRussian ? messagesRu['onboarding_desc_2'] ?? 'Default Description 2' : messagesEn['onboarding_desc_2'] ?? 'Keep track of recipes you love by adding them to your favorites. Never lose a great recipe again!',
      image: Assets.imagesOnboard2,
    ),
    OnboardingData(
      title: isRussian ? messagesRu['onboarding_title_3'] ?? 'Default Title 3' : messagesEn['onboarding_title_3'] ?? 'Need More Ingredients?',
      desc: isRussian ? messagesRu['onboarding_desc_3'] ?? 'Default Description 3' : messagesEn['onboarding_desc_3'] ?? 'Easily add missing ingredients to your shopping list with just a tap',
      image: Assets.imagesOnboard4,
    ),
  ];
}
