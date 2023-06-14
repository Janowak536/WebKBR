import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/contact_page.dart';
import 'package:flutter_2kbr/pages/fronts/front_model_page.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/pages/offer_page.dart';
import 'package:flutter_2kbr/pages/sills/sill_model_page.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      alignment: Alignment.bottomCenter,
      color: Color.fromARGB(255, 27, 27, 27),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kontakt',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 25),
              Text(
                '+48 12 385 84 38',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'biuro@2kbr.pl',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  navigateWithoutAnimation(context, HomePage());
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateWithoutAnimation(context, OfferPage());
                },
                child: Text(
                  'Oferta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateWithoutAnimation(context, ContactPage());
                },
                child: Text(
                  'Kontakt',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateWithoutAnimation(context, LoginPage());
                },
                child: Text(
                  'Strefa Klienta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  navigateWithoutAnimation(context, FrontModelPage());
                },
                child: Text(
                  'Fronty meblowe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateWithoutAnimation(context, SillModelPage());
                },
                child: Text(
                  'Parapety',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
