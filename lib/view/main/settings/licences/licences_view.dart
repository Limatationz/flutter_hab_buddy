import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';
import '../../../../oss_licenses.dart';
import 'single_licence_view.dart';

class LicencesView extends StatelessWidget {
  static const routeName = 'LicencesView';
  static const routePath = '/licences12';

  const LicencesView({super.key});

  static Future<List<Package>> loadLicenses() async {
    // merging non-dart dependency list using LicenseRegistry.
    final lm = <String, List<String>>{};
    await for (var l in LicenseRegistry.licenses) {
      for (var p in l.packages) {
        final lp = lm.putIfAbsent(p, () => []);
        lp.addAll(l.paragraphs.map((p) => p.text));
      }
    }
    final licenses = allDependencies.toList();
    for (var key in lm.keys) {
      if (licenses.any((element) => element.name.toLowerCase().contains(key.toLowerCase()))) continue;
      licenses.add(Package(
        name: key,
        description: '',
        authors: [],
        version: '',
        license: lm[key]!.join('\n\n'),
        isMarkdown: false,
        isSdk: false,
        dependencies: [],
      ));
    }
    return licenses..sort((a, b) => a.name.compareTo(b.name));
  }

  static final _licenses = loadLicenses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).licences),
        ),
        body: FutureBuilder<List<Package>>(
            future: _licenses,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final package = snapshot.data![index];
                    return ListTile(
                      title: Text('${package.name} ${package.version}'),
                      subtitle: package.description.isNotEmpty ? Text(package.description) : null,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.goNamed(SingleLicenceView.routeName, pathParameters: {'name': package.name}),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider());
            }));
  }
}
