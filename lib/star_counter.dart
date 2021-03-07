import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:intl/intl.dart' as intl;

class GitHubStarCounter extends StatefulWidget {
  final String repositoryName;

  GitHubStarCounter({
    required this.repositoryName,
  });
  @override
  _GitHubStarCounterState createState() => _GitHubStarCounterState();
}

class _GitHubStarCounterState extends State<GitHubStarCounter> {
  late GitHub github;
  Repository? repository;
  String? errorMessage;

  void initState() {
    super.initState();
    github = GitHub();

    fetchRepository();
  }

  void didUpdateWidget(GitHubStarCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.repositoryName == oldWidget.repositoryName) {
      return;
    }

    fetchRepository();
  }

  Future<void> fetchRepository() async {
    setState(() {
      repository = null;
      errorMessage = null;
    });

    try {
      var repo = await github.repositories
          .getRepository(RepositorySlug.full(widget.repositoryName));
      setState(() {
        repository = repo;
      });
    } on RepositoryNotFound {
      setState(() {
        repository = null;
        errorMessage = '${widget.repositoryName} not found.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.headline4?.apply(color: Colors.green);
    final errorStyle = textTheme.bodyText1?.apply(color: Colors.red);
    final numberFormat = intl.NumberFormat.decimalPattern();

    if (errorMessage != null) {
      return Text(errorMessage!, style: errorStyle);
    }

    if (widget.repositoryName.isNotEmpty && repository == null) {
      return Text('loading...');
    }

    if (repository == null) {
      return SizedBox();
    }
    return Text(
      '${numberFormat.format(repository!.stargazersCount)}',
      style: textStyle,
    );
  }
}
