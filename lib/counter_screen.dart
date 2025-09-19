import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  final int themeMode;
  final Function changeTheme;
  final String themeModeName;

  const CounterScreen({
    super.key,
    required this.themeMode,
    required this.changeTheme,
    required this.themeModeName,
  });

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  bool _isAnimating = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _isAnimating = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isAnimating = false;
      });
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _isAnimating = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isAnimating = false;
      });
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _isAnimating = true;
    });

    // Reset animation state after a short delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,

        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              // Show theme options dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Theme'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.light_mode),
                          title: Text('Light Theme'),
                          onTap: () {
                            widget.changeTheme(0);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.dark_mode),
                          title: Text('Dark Theme'),
                          onTap: () {
                            widget.changeTheme(1);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('System Theme'),
                          onTap: () {
                            widget.changeTheme(2);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Current theme indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Current Theme: ${widget.themeModeName}',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

            // Animated counter display
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(_isAnimating ? 1.2 : 1.0),
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            SizedBox(height: 40),

            // Counter buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement button
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: Icon(Icons.remove),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    foregroundColor: widget.themeMode < 2 ? Colors.black : Colors.white ,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                SizedBox(width: 20),

                // Reset button
                ElevatedButton(onPressed: _resetCounter, child: Text('Reset')),

                SizedBox(width: 20),

                // Increment button
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    foregroundColor: widget.themeMode < 2 ? Colors.black : Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Theme toggle button
            ElevatedButton.icon(
              onPressed: () {
                // Cycle through themes (0→1→2→0)
                widget.changeTheme((widget.themeMode + 1) % 3);
              },
              icon: Icon(Icons.color_lens),
              label: Text('Switch Theme'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
