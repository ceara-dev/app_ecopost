import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  Future<PermissionStatus> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status;
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  Future<bool> handleLocationPermission() async {
    if (await isPermissionGranted(Permission.location)) {
      print("Permissão de localização já concedida.");
      return true;
    }

    final status = await requestPermission(Permission.location);

    if (status.isGranted) {
      print("Permissão de localização concedida.");
      return true;
    } else if (status.isPermanentlyDenied) {
      print(
          "Permissão de localização negada permanentemente. Redirecionando para as configurações...");
      await openAppSettings();
      return false;
    } else {
      print("Permissão de localização negada.");
      return false;
    }
  }
}
