import 'package:firebase_remote_config/firebase_remote_config.dart';

class VersionChecker {
  static Future<String> fetchLatestVersionFromRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 30),
    ));
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getString('latest_version');
  }

   static Future<bool> fetchForceUpdateFromRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 30),
    ));
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getBool('force_update');
  }
}
