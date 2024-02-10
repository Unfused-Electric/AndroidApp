import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  final String phoneNumber;

  CallButton({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _makePhoneCall(phoneNumber),
      child: Icon(Icons.call),
      backgroundColor: Colors.green,
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneCallUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneCallUri)) {
      await launchUrl(phoneCallUri);
    } else {
      print('Could not launch $phoneCallUri');
    }
  }
}
