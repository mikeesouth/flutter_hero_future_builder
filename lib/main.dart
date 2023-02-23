import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const heroTag = 'hero321';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero animations with FutureBuilder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Hero(
              tag: heroTag,
              child: FlutterLogo(size: 300),
            ),
          ),
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              _buildButton(
                context,
                'No Future Builder',
                const PageWithoutFuture(),
              ),
              _buildButton(
                context,
                'Future Builder (completed)',
                const PageWithFuture(futureCompleted: true),
              ),
              _buildButton(
                context,
                'Future Builder (delay)',
                const PageWithFuture(futureCompleted: false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext ctx, String buttonText, Widget secondPage) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      padding: const EdgeInsets.all(20.0),
      onPressed: () => Navigator.of(ctx)
          .push(MaterialPageRoute(builder: (ctx) => secondPage)),
      child: Text(buttonText),
    );
  }
}

class PageWithoutFuture extends StatelessWidget {
  const PageWithoutFuture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Hero(
        tag: heroTag,
        child: FlutterLogo(size: 300),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.chevron_left),
      ),
    );
  }
}

class PageWithFuture extends StatefulWidget {
  final bool futureCompleted;

  const PageWithFuture({super.key, required this.futureCompleted});

  @override
  State<PageWithFuture> createState() => _PageWithFutureState();
}

class _PageWithFutureState extends State<PageWithFuture> {
  late Future _initFuture;

  @override
  void initState() {
    super.initState();

    if (widget.futureCompleted) {
      _initFuture = Future.value(true);
    } else {
      _initFuture = Future.delayed(const Duration(seconds: 1), () => true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Text('Waiting!', style: TextStyle(fontSize: 20));
          }

          return const Hero(
            tag: heroTag,
            child: FlutterLogo(size: 300),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.chevron_left),
      ),
    );
  }
}
