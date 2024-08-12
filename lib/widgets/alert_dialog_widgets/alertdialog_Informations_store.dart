import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AlertDialogInformationsStore extends StatefulWidget {
  const AlertDialogInformationsStore({super.key});

  @override
  State<AlertDialogInformationsStore> createState() =>
      _AlertDialogInformationsStoreState();
}

class _AlertDialogInformationsStoreState
    extends State<AlertDialogInformationsStore> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: ColorsAppGeneral.channelNotificationColor,
      surfaceTintColor: ColorsAppGeneral.channelNotificationColor,
      insetPadding: const EdgeInsets.all(15),
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: ColorsAppGeneral
                              .borderChannelNotificationColor))),
              alignment: Alignment.center,
              child: const Text(
                'Informations',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: 4.5,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star_rounded,
                          color: Color(0xffFFB341),
                        ),
                        unratedColor: Colors.white,
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      const Text(
                        '4,5',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '1,7k reviews',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Open Now',
                    style: TextStyle(
                        color: ColorsAppGeneral.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  openingHours('Monday', '18h às 23h'),
                  openingHours('Tuesday', '18h às 23h'),
                  openingHours('Wednesday', '18h às 23h'),
                  openingHours('Trhursday', '18h às 23h'),
                  openingHours('Friday', '18h às 23h'),
                  openingHours('Saturday', '18h às 23h'),
                  openingHours('Sunday', '18h às 23h'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment methods',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'View More',
                        style: TextStyle(
                          color: ColorsAppGeneral.mainColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pix: 0192901823/213-009/324',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Credit/Debit Card',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: ColorsAppGeneral.iconsGeneralColor,
                                size: 20,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Location',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Icon(
                        PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
                        size: 20,
                        color: ColorsAppGeneral.iconsGeneralColor,
                      ),
                      const Text(
                        'Av. B Quadra 298, Lote 23. Cidade Jardim, Parauapebas-PA',
                        style: TextStyle(color: Colors.white, fontSize: 11.5),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsAppGeneral.mainColor),
          child: TextButton(
            child: const Text(
              'Edit',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffEE4848)),
          child: TextButton(
            child: const Text(
              'Cancel',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}

Widget openingHours(dayName, hour) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 185,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dayName,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              hour,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: ColorsAppGeneral.descriptionColor,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 100,
        height: 20,
      )
    ],
  );
}
