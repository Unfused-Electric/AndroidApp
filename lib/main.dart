import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'call_widget.dart'; // Make sure this points to your CallButton widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unfused Electric App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black.withOpacity(0.8),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black.withOpacity(0.8),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Custom initialization of _controller
    // The following initialization is conceptual and may need adjustment
    // based on your WebViewWidget's implementation
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            Uri uri = Uri.parse(request.url);
            if (uri.scheme == 'tel' || uri.scheme == 'mailto') {
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.unfusedelectric.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unfused Electric'),
      ),
      body: Stack(
        children: <Widget>[
          WebViewWidget(controller: _controller), // Your custom WebViewWidget
          Positioned(
            top: 20,
            right: 20,
            child: CallButton(
                phoneNumber: '123-456-7890'), // Your custom CallButton widget
          ),
        ],
      ),
    );
  }
}
