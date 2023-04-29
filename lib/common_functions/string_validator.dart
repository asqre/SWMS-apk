import 'package:url_launcher/url_launcher.dart';

String? checkNameEmpty(String? nameContent) {
  if (nameContent == null || nameContent.isEmpty) {
    return 'Please enter your name';
  }
  bool isNameValid =
  RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
      .hasMatch(nameContent);
  if (!isNameValid) {
    return 'Invalid name input. Try again';
  }
  return null;
}

String? checkPhoneEmpty(String? phoneContent) {
  if (phoneContent == null || phoneContent.isEmpty) {
    return "enter your 10 digits phone no.";
  }
  if (phoneContent.length < 10) {
    return "please enter your correct phone no";
  }
  bool isPhoneNoValid =
  RegExp(r"^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
      .hasMatch(phoneContent);
  if (!isPhoneNoValid) {
    return "please enter your valid phone no";
  }
  return null;
}

String? checkEmailEmpty(String? emailContent) {
  if (emailContent == null || emailContent.isEmpty) {
    return "please enter your mail id";
  }
  bool isEmailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(emailContent);
  if (!isEmailValid) {
    return "Invalid email, try again";
  }
  return null;
}

String? checkPasswordEmpty(String? passwordContent) {
  if (passwordContent == null || passwordContent.isEmpty) {
    return "please enter your password";
  }
  if (passwordContent.length < 6) {
    return "password must be of at least 6 characters";
  }
  bool isValidPassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}')
      .hasMatch(passwordContent);
  if (!isValidPassword) {
    return "wrong password input";
  }
  return null;
}


// to launch url in same app
LaunchApplicationURL(String url) async {
  final webUrl = Uri.parse(url);
  if (await canLaunchUrl(webUrl)) {
    await launchUrl(webUrl, mode: LaunchMode.platformDefault);
  } else {
    throw 'could not open $webUrl';
  }
}

// to launch url in that particular apps
LaunchWebURL(String url) async {
  final webUrl = Uri.parse(url);
  if(await canLaunchUrl(webUrl)){
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }else{
    throw 'could not open $webUrl';
  }
}
