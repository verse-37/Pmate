import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfo {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static Map<String, dynamic> deviceInfo = <String, dynamic>{};
  static Map<String, dynamic> deviceGenericInfo = <String, dynamic>{};

  static Future<void> initPlatform() async {
    try {
      deviceGenericInfo = (await deviceInfoPlugin.deviceInfo).data;

      if (kIsWeb) {
        deviceInfo = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        deviceInfo = switch (defaultTargetPlatform) {
          TargetPlatform.android =>
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
          TargetPlatform.iOS =>
            _readIOSBuildData(await deviceInfoPlugin.iosInfo),
          TargetPlatform.linux =>
            _readLinuxBuildData(await deviceInfoPlugin.linuxInfo),
          TargetPlatform.macOS =>
            _readMacOSBuildData(await deviceInfoPlugin.macOsInfo),
          TargetPlatform.windows =>
            _readWindowsBuildData(await deviceInfoPlugin.windowsInfo),
          TargetPlatform.fuchsia => <String, dynamic>{
              "error": "The Fuchsia is not supported",
            },
        };
      }
    } on PlatformException catch (e) {
      deviceInfo = <String, dynamic>{
        "error": e.message ?? "Unknown error",
      };
    }
  }

  static Map<String, dynamic> _readAndroidBuildData(
      AndroidDeviceInfo androidInfo) {
    return <String, dynamic>{
      'version.securityPatch': androidInfo.version.securityPatch,
      'version.sdkInt': androidInfo.version.sdkInt,
      'version.release': androidInfo.version.release,
      'version.previewSdkInt': androidInfo.version.previewSdkInt,
      'version.incremental': androidInfo.version.incremental,
      'version.codename': androidInfo.version.codename,
      'version.baseOS': androidInfo.version.baseOS,
      'board': androidInfo.board,
      'bootloader': androidInfo.bootloader,
      'brand': androidInfo.brand,
      'device': androidInfo.device,
      'display': androidInfo.display,
      'fingerprint': androidInfo.fingerprint,
      'hardware': androidInfo.hardware,
      'host': androidInfo.host,
      'id': androidInfo.id,
      'manufacturer': androidInfo.manufacturer,
      'model': androidInfo.model,
      'product': androidInfo.product,
      'supported32BitAbis': androidInfo.supported32BitAbis,
      'supported64BitAbis': androidInfo.supported64BitAbis,
      'supportedAbis': androidInfo.supportedAbis,
      'tags': androidInfo.tags,
      'type': androidInfo.type,
      'isPhysicalDevice': androidInfo.isPhysicalDevice,
      'systemFeatures': androidInfo.systemFeatures,
      'serialNumber': androidInfo.serialNumber,
      'isLowRamDevice': androidInfo.isLowRamDevice,
    };
  }

  static Map<String, dynamic> _readIOSBuildData(IosDeviceInfo iosInfo) {
    return <String, dynamic>{
      'name': iosInfo.name,
      'systemName': iosInfo.systemName,
      'systemVersion': iosInfo.systemVersion,
      'model': iosInfo.model,
      'localizedModel': iosInfo.localizedModel,
      'identifierForVendor': iosInfo.identifierForVendor,
      'isPhysicalDevice': iosInfo.isPhysicalDevice,
      'utsname.machine': iosInfo.utsname.machine,
      'utsname.nodename': iosInfo.utsname.nodename,
      'utsname.release': iosInfo.utsname.release,
      'utsname.sysname': iosInfo.utsname.sysname,
      'utsname.version': iosInfo.utsname.version,
    };
  }

  static Map<String, dynamic> _readLinuxBuildData(LinuxDeviceInfo linuxInfo) {
    return <String, dynamic>{
      'name': linuxInfo.name,
      'version': linuxInfo.version,
      'id': linuxInfo.id,
      'idLike': linuxInfo.idLike,
      'versionCodename': linuxInfo.versionCodename,
      'versionId': linuxInfo.versionId,
      'prettyName': linuxInfo.prettyName,
      'buildId': linuxInfo.buildId,
      'variant': linuxInfo.variant,
      'variantId': linuxInfo.variantId,
      'machineId': linuxInfo.machineId,
    };
  }

  static Map<String, dynamic> _readWebBrowserInfo(
      WebBrowserInfo webBrowserInfo) {
    return <String, dynamic>{
      'browserName': webBrowserInfo.browserName,
      'appCodeName': webBrowserInfo.appCodeName,
      'appName': webBrowserInfo.appName,
      'appVersion': webBrowserInfo.appVersion,
      'deviceMemory': webBrowserInfo.deviceMemory,
      'language': webBrowserInfo.language,
      'languages': webBrowserInfo.languages,
      'platform': webBrowserInfo.platform,
      'product': webBrowserInfo.product,
      'productSub': webBrowserInfo.productSub,
      'userAgent': webBrowserInfo.userAgent,
      'vendor': webBrowserInfo.vendor,
      'vendorSub': webBrowserInfo.vendorSub,
    };
  }

  static Map<String, dynamic> _readMacOSBuildData(MacOsDeviceInfo macosInfo) {
    return <String, dynamic>{
      'computerName': macosInfo.computerName,
      'hostName': macosInfo.hostName,
      'arch': macosInfo.arch,
      'model': macosInfo.model,
      'kernelVersion': macosInfo.kernelVersion,
      'majorVersion': macosInfo.majorVersion,
      'minorVersion': macosInfo.minorVersion,
      'patchVersion': macosInfo.patchVersion,
      'osRelease': macosInfo.osRelease,
      'activeCPUs': macosInfo.activeCPUs,
      'cpuFrequency': macosInfo.cpuFrequency,
      'memorySize': macosInfo.memorySize,
      'systemGUID': macosInfo.systemGUID,
    };
  }

  static Map<String, dynamic> _readWindowsBuildData(
      WindowsDeviceInfo windowsInfo) {
    return <String, dynamic>{
      'numberOfCores': windowsInfo.numberOfCores,
      'computerName': windowsInfo.computerName,
      'systemMemoryInMegabytes': windowsInfo.systemMemoryInMegabytes,
      'userName': windowsInfo.userName,
      'majorVersion': windowsInfo.majorVersion,
      'minorVersion': windowsInfo.minorVersion,
      'buildNumber': windowsInfo.buildNumber,
      'platformId': windowsInfo.platformId,
      'csdVersion': windowsInfo.csdVersion,
      'servicePackMajor': windowsInfo.servicePackMajor,
      'servicePackMinor': windowsInfo.servicePackMinor,
      'suitMask': windowsInfo.suitMask,
      'productType': windowsInfo.productType,
      'reserved': windowsInfo.reserved,
      'buildLab': windowsInfo.buildLab,
      'buildLabEx': windowsInfo.buildLabEx,
      'digitalProductId': windowsInfo.digitalProductId,
      'displayVersion': windowsInfo.displayVersion,
      'editionId': windowsInfo.editionId,
      'installDate': windowsInfo.installDate,
      'productId': windowsInfo.productId,
      'productName': windowsInfo.productName,
      'registeredOwner': windowsInfo.registeredOwner,
      'releaseId': windowsInfo.releaseId,
      'deviceId': windowsInfo.deviceId,
    };
  }
}
