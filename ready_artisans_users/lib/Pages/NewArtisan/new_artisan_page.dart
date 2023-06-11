import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ready_artisans/Providers/navigation_provider.dart';
import 'package:ready_artisans/Styles/app_colors.dart';

import '../../generated/assets.dart';
import 'image_section.dart';
import 'service_details.dart';

class NewArtisanPage extends StatelessWidget {
  const NewArtisanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(builder: (context, nav, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          elevation: 0,
          title: Image.asset(
            Assets.imagesLogoHT,
            height: 100,
            fit: BoxFit.fitHeight,
          ),
        ),
        body: IndexedStack(
          index: nav.newIndex,
          children: const [ImagesSection(), ServiceDetails()],
        ),
      );
    });
  }
}
