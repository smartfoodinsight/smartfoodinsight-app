import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/extensions/app_localizations_extension.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.loc.information)),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: const Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale'),
                subtitle:
                    Text('Music by Julie Gable. Lyrics by Sidney Stein.')),
          ])),
        ));
  }
}
