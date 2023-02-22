import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:posts_app/core/utils/app_strings.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            '${AppStrings.lottie}no_internet.json',
            repeat: false,
          ),
          const SizedBox(height: 20),
          Text(
            'no internet connection available',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              PostsCubit.get(context).getAllPosts();
            },
            child: const Text('Try Again'),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
