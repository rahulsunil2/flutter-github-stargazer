import 'package:flutter/material.dart';
import 'star_counter.dart';

void main() {
  runApp(StarCounterApp());
}

class StarCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          '/': (context) => HomePage(),
          '/privacy_policy': (context) => PrivacyPolicy()
        });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _repositoryName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'GitHub Star Counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter a GitHub Repo',
                      hintText: 'flutter/flutter',
                    ),
                    onSubmitted: (text) {
                      setState(() {
                        _repositoryName = text;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: GitHubStarCounter(
                      repositoryName: _repositoryName,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/privacy_policy');
                    },
                    child: Text('Privacy Policy'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Privacy Policy",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Flutter Example Company built the Star Counter app as an Open Source app. This SERVICE is provided by Flutter Example Company at no cost and is intended for use as is. This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service. If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is  used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in  this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Star Counter unless otherwise defined in this Privacy Policy.",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(0, 49, 83, 255)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text(
                      "Go Back",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
