import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/contact_page.dart';
import 'package:flutter_2kbr/pages/fronts/front_model_page.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/pages/offer_page.dart';
import 'package:flutter_2kbr/pages/sills/sill_model_page.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      alignment: Alignment.bottomCenter,
      color: const Color.fromARGB(255, 27, 27, 27),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  'Kontakt',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 35),
              Flexible(
                child: Text(
                  '+48 12 385 84 38',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Flexible(
                child: Text(
                  'biuro@2kbr.pl',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextButton(
                  onPressed: () {
                    navigateWithoutAnimation(context, HomePage());
                  },
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    navigateWithoutAnimation(context, OfferPage());
                  },
                  child: const Text(
                    'Oferta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    navigateWithoutAnimation(context, ContactPage());
                  },
                  child: const Text(
                    'Kontakt',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    navigateWithoutAnimation(context, const LoginPage());
                  },
                  child: const Text(
                    'Strefa Klienta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextButton(
                  onPressed: () {
                    navigateWithoutAnimation(context, FrontModelPage());
                  },
                  child: const Text(
                    'Fronty meblowe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    navigateWithoutAnimation(context, SillModelPage());
                  },
                  child: const Text(
                    'Parapety',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
