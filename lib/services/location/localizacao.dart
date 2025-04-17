import 'package:location/location.dart';
import '../../enums/status_console.dart';
import '../../helpers/console_log.dart';
import '../permission/permission_manager.dart';

class Localizacao {
  final PermissionManager _permissionManager = PermissionManager();
  final Location _location = Location();

  Future<LocationData?> obterLocalizacaoAtual() async {
    // Verifica e solicita permissão de localização
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
      // Obtém a localização atual
      final locationData = await _location.getLocation();

      ConsoleLog.mensagem(
        titulo: 'Localização obtida',
        mensagem:
            "Latitude=${locationData.latitude}, Longitude=${locationData.longitude}",
        tipo: StatusConsole.sucesso,
      );

      return locationData;
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
