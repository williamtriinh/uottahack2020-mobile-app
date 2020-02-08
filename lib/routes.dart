import "package:flutter/material.dart";

import "package:app/home_page.dart";
import "package:app/login_page.dart";
import "package:app/medication_page.dart";
import "package:app/signup_page.dart";
import "package:app/splash_page.dart";

const String homePage = "/homePage";
const String loginPage = "/loginPage";
const String medicationPage = "/medicationPage";
const String signupPage = "/signupPage";
const String splashPage = "/splashPage";

final Map<String, WidgetBuilder> routes =
{
  homePage: (BuildContext context) => new HomePage(),
  loginPage: (BuildContext context) => new LoginPage(),
  medicationPage: (BuildContext context) => new MedicationPage(),
  signupPage: (BuildContext context) => new SignupPage(),
  splashPage: (BuildContext context) => new SplashPage()
};