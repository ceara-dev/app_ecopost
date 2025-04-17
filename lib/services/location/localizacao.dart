import 'package:geolocator/geolocator.dart';
import '../../enums/status_console.dart';
import '../../helpers/console_log.dart';
import '../permission/permission_manager.dart';

class Localizacao {
  final PermissionManager _permissionManager = PermissionManager();

  Future<Position?> obterLocalizacaoAtual() async {
    final isGranted = await _permissionManager.handleLocationPermission();
    if (!isGranted) {
      ConsoleLog.mensagem(
        titulo: 'obterLocalizacaoAtual',
        mensagem: 'Permissão de localização não concedida.',
        tipo: StatusConsole.error,
      );
      return null;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );

      ConsoleLog.mensagem(
        titulo: 'Localização obtida',
        mensagem:
            "Latitude=${position.latitude}, Longitude=${position.longitude}",
        tipo: StatusConsole.sucesso,
      );
      return position;
    } catch (e) {
      ConsoleLog.mensagem(
        titulo: 'Erro ao obter localização',
        mensagem: e.toString(),
        tipo: StatusConsole.error,
      );
      return null;
    }
  }
}
