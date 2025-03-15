# Credi Q Tech Test

CrediQ Technical Test - Multiplatform

### Contenido

## HomePage
Pagina de inicio donde se muestra el catalogo de juegos de NeoGame

## Detalles el juego 
Pantalla donde se muestran los detalles del juego y su informacion relevante

## Checkout
Pantalla donde se muestra el resumen de la compra para que el cliente pueda finalizarlo


## Requisitos Previos ----------------

### 1. Instalar Flutter
Ve a la página oficial de Flutter [https://flutter.dev](https://flutter.dev) y sigue las instrucciones de instalación para tu sistema operativo (Windows, macOS o Linux).

Asegúrate de tener la última versión de Flutter ejecutando el siguiente comando en tu terminal:
```bash
flutter upgrade
```

### 2. Instalar Android Studio o Visual Studio Code
Flutter funciona con Android Studio y Visual Studio Code. Se recomienda Android Studio para un entorno más completo, ya que incluye un emulador.

Android Studio: Descarga e instala aquí.
Visual Studio Code: Descarga e instala aquí.
### 3. Instalar Xcode (solo para macOS)
Si desarrollas para iOS, necesitarás Xcode. Descárgalo desde la App Store.

### 4. Verificar la Instalación
Después de instalar todo, abre la terminal y ejecuta el siguiente comando para verificar que Flutter está correctamente instalado:

```bash
flutter doctor
```
Este comando revisará si hay algún componente faltante (como dependencias de Android, Xcode, etc.) y te sugerirá cómo corregirlo.

Pasos para Correr la Aplicación Flutter
1. Clonar o Descargar el Proyecto
Si el proyecto está en un repositorio de Git, clónalo usando:

```bash
git clone <URL del repositorio>
```

Si tienes un archivo ZIP del proyecto, simplemente descomprímelo en la ubicación de tu preferencia.

2. Abrir el Proyecto
Abre el directorio del proyecto en el editor que prefieras (Android Studio o Visual Studio Code).

3. Instalar Dependencias
Navega a la carpeta del proyecto usando la terminal y ejecuta el siguiente comando para instalar todas las dependencias necesarias:

```bash
flutter pub get
```

4. Seleccionar el Emulador o Dispositivo Físico
Si estás trabajando con Android, puedes ejecutar un emulador desde Android Studio. Si estás desarrollando para iOS, asegúrate de tener un simulador de iOS o un dispositivo conectado.

5. Correr la Aplicación
Desde la terminal, estando en el directorio raíz del proyecto, ejecuta el siguiente comando:

```bash
flutter run
```

También puedes correr la aplicación desde el editor seleccionando el dispositivo (emulador o físico) y presionando el botón de "Run".

Solución de Problemas Comunes
1. Errores de Dependencias
Si recibes errores relacionados con dependencias, intenta correr:

```bash
flutter clean
flutter pub get
```

2. Problemas con el Emulador
Asegúrate de tener el emulador correctamente configurado en Android Studio o Xcode. Si el emulador no responde, reinícialo o crea uno nuevo.

3. Errores de Plataforma (Android/iOS)
Si ves un error relacionado con las plataformas, asegúrate de haber configurado correctamente los entornos de Android y iOS (como Android SDK, Xcode, etc.).

Opciones Adicionales
Correr en modo Debug
```bash
flutter run --debug
```

Correr en modo Release (para pruebas de rendimiento o publicación)
```bash
flutter run --release
```

Ver logs de la aplicación
```bash
flutter logs
```
