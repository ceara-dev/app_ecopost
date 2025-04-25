# EcoPost

## 📌 Assinatura do Aplicativo Para assinar o aplicativo Android, é necessário gerar um **JKS (Java KeyStore)**. Execute o seguinte comando no terminal:

```
sh keytool -genkeypair -v -keystore ecopost.jks -keyalg RSA -keysize 2048 -validity 10000 -alias ecopost
```

---

## 📌 Permissão para o Arquivo run.sh

Antes de executar os scripts run.sh, certifique-se de que o arquivo tenha permissão de execução. Para isso, execute o seguinte comando no terminal:

```
chmod +x run.sh
```

---

## 📌 Configuração da Splash Screen Para gerar a tela de abertura (splash screen), execute:

```
sh flutter pub run flutter_native_splash:create
```

---

## 📌 Configuração dos Ícones Para criar os ícones do aplicativo, rode o seguinte comando:

```
sh flutter pub run flutter_launcher_icons:main
```

---

## 📌 Execução com Flavors Comandos para executar o aplicativo com diferentes flavors:

```
sh fvm flutter run --flavor defaultFlavor
```

Scripts personalizados para ambientes específicos:
.Homologação :

```
sh run.sh homolog
```

.Produção :

```
sh run.sh prod
```

.Desenvolvimento

```
sh run.sh dev
```

---

## 📌 Build APK Para gerar o APK de produção, execute:

```
sh fvm flutter build apk --release --flavor producao -t lib/main_prod.dart
```

---

### Observações:

- Certifique-se de que os scripts `run.sh` estejam configurados corretamente para cada ambiente.
- O arquivo `lib/main_prod.dart` deve existir e estar configurado para o ambiente de produção.

---

Este novo formato organiza os comandos por ambiente (**Desenvolvimento**, **Homologação** e **Produção**) e mantém o conteúdo exatamente como solicitado.
