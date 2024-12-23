import 'package:collection/collection.dart';
import '../core/database/app_database.dart';
import '../core/network/converters/rule.dart';
import '../core/network/generated/openHAB.swagger.dart' hide Rule;
import '../locator.dart';
import 'login_repository.dart';

class AutomationRepository {
  final _loginRepository = locator<LoginRepository>();
  final _store = locator<AppDatabase>().rulesStore;

  Stream<List<Rule>> get rules => _store.all().watch();

  AutomationRepository() {
    _store.all().watch().listen((event) {
      print('Rules updated');
    });
  }

  Future<void> fetchData() async {
    await _loginRepository.firstConnectionComplete.future;
    final result = await locator<OpenHAB>().rulesGet();
    if (result.isSuccessful) {
      final storedRules = await _store.all().get();

      for (final rule in result.body!) {
        final storedRule =
            storedRules.firstWhereOrNull((element) => element.uid == rule.uid);
        final dbRule = rule.asDatabaseModel();
        if (dbRule == null) {
          print('Rule is not valid. Uid: ${rule.uid}');
          continue;
        } else {
          if (storedRule == null) {
            // Item is not stored yet
            _store.insertOrUpdateSingle(dbRule.toCompanion(true));
          } else {
            // Item is already stored -> update
            _store.insertOrUpdateSingle(dbRule.toCompanion(true));
          }

          // remove from storedRules
          storedRules.removeWhere((element) => element.uid == rule.uid);
        }
      }

      // Delete all rules that are not available anymore
      for (final rule in storedRules) {
        await _store.deleteDataByUid(rule.uid);
      }
    } else {
      print(result.error);
    }
  }

  Future<bool> triggerRule(String ruleUid) async {
    final result = await locator<OpenHAB>()
        .rulesRuleUIDRunnowPost(ruleUID: ruleUid, body: null);
    return result.isSuccessful;
  }
}
