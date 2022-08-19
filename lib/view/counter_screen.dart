
import 'package:flutter/material.dart';
import 'package:flutter_template/viewmodel/counter_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.counterDescription),
            Text(
              '${Provider.of<CounterViewModel>(context).counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CounterViewModel>(context, listen: false).increment(),
        tooltip: AppLocalizations.of(context)!.incrementTip,
        child: const Icon(Icons.add),
      ),
    );
  }

}