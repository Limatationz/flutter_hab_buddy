import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../oss_licenses.dart';

class SingleLicenceView extends StatelessWidget {
  static const routeName = 'SingleLicenceView';
  static const routePath = '/view/:name';

  final Package? package;
  final String packageName;

  const SingleLicenceView({super.key, this.package, required this.packageName});

  Future<Package?> loadLicenses() async {
    if (package != null) {
      return package!;
    }

    // when the package is not generated we use licenseregistry to get the license
    final lm = <String, List<String>>{};
    await for (var l in LicenseRegistry.licenses) {
      for (var p in l.packages) {
        final lp = lm.putIfAbsent(p, () => []);
        lp.addAll(l.paragraphs.map((p) => p.text));
      }
    }
    if (lm.containsKey(packageName)) {
      final entry = lm["$packageName"];
      return Package(
        name: packageName,
        description: '',
        authors: [],
        version: '',
        license: entry?.join('\n\n'),
        isMarkdown: false,
        isSdk: false,
        dependencies: [],
      );
    } else {
      print("Could not find package $packageName");
      return null;
    }
  }

  String _bodyText(Package package) {
    return package.license!.split('\n').map((line) {
      if (line.startsWith('//')) line = line.substring(2);
      line = line.trim();
      return line;
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${packageName}')),
      body: FutureBuilder(
          future: loadLicenses(),
          builder: (context, future) {
            if (!future.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final package = future.data!;
            return ListView(children: <Widget>[
                  if (package.description.isNotEmpty)
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 12.0, right: 12.0),
                        child: Text(package.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold))),
                  if (package.homepage != null)
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 12.0, right: 12.0),
                        child: InkWell(
                          child: Text(package.homepage!,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                          onTap: () => launchUrlString(package.homepage!),
                        )),
                  if (package.description.isNotEmpty ||
                      package.homepage != null)
                    const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: Text(_bodyText(package),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ]);
          }),
    );
  }
}
