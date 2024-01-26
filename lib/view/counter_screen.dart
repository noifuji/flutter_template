// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:flutter_template/viewmodel/counter_viewmodel.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cv = Provider.of<CounterViewModel>(context).counter;
    const flavorName = String.fromEnvironment('flavor');
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.appTitle}($flavorName)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.counterDescription),
            Text(
              '${cv.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(AppLocalizations.of(context)!.updateDateDescription),
            Text(cv.updateDate.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<CounterViewModel>(context, listen: false).increment(),
        tooltip: AppLocalizations.of(context)!.incrementTip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
