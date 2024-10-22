import 'package:flutter/material.dart';

const colors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigoAccent,
  Colors.purpleAccent,
];

class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  int numItems = 20;

  bool extendNav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extendNav,
            useIndicator: true,
            indicatorShape: OvalBorder(),
            destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.access_alarm), label: Text('expand')),
              NavigationRailDestination(
                  icon: Icon(Icons.receipt_long), label: Text('set list items'))
            ],
            selectedIndex: 0,
            onDestinationSelected: (v) {
              if (v == 0) {
                setState(() {
                  extendNav = !extendNav;
                });
                return;
              }
              // Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Set Number of Items"),
                    content: TextField(
                      decoration: InputDecoration(
                        labelText: 'Number of Items',
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        setState(() {
                          numItems = int.tryParse(value) ?? 50;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text('Sliver Page'),
                  floating: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF34A853), Color(0xFF4285F4)],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                  expandedHeight: 200,
                ),
                SliverTitleBlock(
                    title: 'Sliver Title',
                    description:
                        'this is pretty cool, right? its interesting what can be done with slivers.',
                    icon: Icons.tv_outlined),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Item number $index'),
                        subtitle: Text('there are may other items'),
                        tileColor: colors[index % colors.length],
                      );
                    },
                    childCount: numItems,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliverTitleBlock extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  SliverTitleBlock(
      {required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: <Widget>[
                Icon(icon, size: 48),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
