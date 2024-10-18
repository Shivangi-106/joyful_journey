import 'package:flutter/material.dart';

class JoyfullJourneyHomePage extends StatelessWidget {
  const JoyfullJourneyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Joyfull Journey',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MenuButton(
                      icon: 'lib/assets/Nature_icon.png',
                      label: 'Nature Learning',
                      route: '/nature'),
                  MenuButton(
                    icon: 'lib/assets/Learning_icon.png',
                    label: 'Learning',
                    route: '/learning',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MenuButton(
                    icon: 'lib/assets/Game_icon.png',
                    label: 'Gaming',
                    route: '/games',
                  ),
                  MenuButton(
                    icon: 'lib/assets/Community_icon.png',
                    label: 'Community Chat',
                    route: '/community',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String icon;
  final String label;
  final String route;

  const MenuButton({super.key, required this.icon, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 120,
              height: 120,
              child: Center(
                child: Image.asset(
                  icon,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
