import 'package:location/location.dart';
import '../../enums/status_console.dart';
import '../../helpers/console_log.dart';
import '../permission/permission_manager.dart';

class Localizacao {
  final PermissionManager _permissionManager = PermissionManager();
  final Location _location = Location();

  Future<LocationData?> obterLocalizacaoAtual() async {
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

  Future<List<double>> getobterLocalizacaoAtual() async {
    final isGranted = await _permissionManager.handleLocationPermission();
    if (!isGranted) {
      ConsoleLog.mensagem(
        titulo: 'getobterLocalizacaoAtual',
        mensagem: 'Permissão de localização não concedida.',
        tipo: StatusConsole.error,
      );
      return [0, 0];
    }

    try {
      final locationData = await _location.getLocation();

      ConsoleLog.mensagem(
        titulo: 'Localização obtida',
        mensagem:
            "Latitude=${locationData.latitude}, Longitude=${locationData.longitude}",
        tipo: StatusConsole.sucesso,
      );

      if (locationData.latitude != null && locationData.longitude != null) {
        return [locationData.latitude!, locationData.longitude!];
      }
      ConsoleLog.mensagem(
        titulo: 'getobterLocalizacaoAtual',
        mensagem: 'Latitude ou longitude inválida.',
        tipo: StatusConsole.error,
      );
      return [0, 0];
    } catch (e) {
      ConsoleLog.mensagem(
        titulo: 'Erro ao obter localização',
        mensagem: e.toString(),
        tipo: StatusConsole.error,
      );
      return [0, 0];
    }
  }
}
