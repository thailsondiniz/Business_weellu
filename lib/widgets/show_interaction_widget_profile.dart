import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/pages/business_catalog/createCatalog.dart';
import 'package:flutter_project_business/pages/business_catalog/show_catalog_general.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShowInteractionWidgetProfile extends StatefulWidget {
  final String dadosUser;
  final String userId;
  final String nameBusiness;
  const ShowInteractionWidgetProfile(
      {super.key,
      required this.nameBusiness,
      required this.dadosUser,
      required this.userId});

  @override
  State<ShowInteractionWidgetProfile> createState() =>
      _ShowInteractionWidgetProfileState();
}

class _ShowInteractionWidgetProfileState
    extends State<ShowInteractionWidgetProfile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowCatalogGeneral(
                            dadosUser: widget.dadosUser,
                            userId: widget.userId,
                          )),
                );
              },
              child: Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.only(top: 13),
                decoration: BoxDecoration(
                  color: ColorsAppGeneral.channelNotificationColor,
                  // border: Border.all(color: ColorsAppGeneral.mainColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Icon(
                      size: 25,
                      color: ColorsAppGeneral.mainColor,
                      PhosphorIcons.storefront(
                        PhosphorIconsStyle.regular,
                      ),
                    ),
                    const Text(
                      'Catalog',
                      style: TextStyle(
                        color: ColorsAppGeneral.mainColor,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.only(top: 13),
              decoration: BoxDecoration(
                color: ColorsAppGeneral.channelNotificationColor,
                // border: Border.all(color: ColorsAppGeneral.mainColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Icon(
                    size: 25,
                    color: ColorsAppGeneral.mainColor,
                    PhosphorIcons.shareNetwork(PhosphorIconsStyle.regular),
                  ),
                  const Text(
                    'Share',
                    style: TextStyle(
                        color: ColorsAppGeneral.mainColor, fontSize: 13),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.only(top: 13),
              decoration: BoxDecoration(
                color: ColorsAppGeneral.channelNotificationColor,
                // border: Border.all(color: ColorsAppGeneral.mainColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Icon(
                    size: 25,
                    color: ColorsAppGeneral.mainColor,
                    PhosphorIcons.shareFat(
                      PhosphorIconsStyle.regular,
                    ),
                  ),
                  const Text(
                    'Send',
                    style: TextStyle(
                        color: ColorsAppGeneral.mainColor, fontSize: 13),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateCatalog(
                            nameBusiness: widget.nameBusiness,
                            userId: widget.userId,
                            dadosUser: widget.dadosUser,
                          )),
                );
              },
              child: Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.only(top: 13),
                decoration: BoxDecoration(
                  color: ColorsAppGeneral.channelNotificationColor,
                  // border: Border.all(color: ColorsAppGeneral.mainColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Icon(
                      size: 25,
                      color: ColorsAppGeneral.mainColor,
                      PhosphorIcons.plus(
                        PhosphorIconsStyle.bold,
                      ),
                    ),
                    const Text(
                      'Product',
                      style: TextStyle(
                          color: ColorsAppGeneral.mainColor, fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
