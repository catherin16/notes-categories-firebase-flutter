# App Flutter con Firebase

## Descripción

Esta aplicación Flutter permite a los usuarios registrarse e iniciar sesión mediante correo y contraseña, utilizando **Firebase Authentication**.
Además, la app permite crear y mostrar notas almacenadas en **Firebase Firestore**.

## Tecnologías y Herramientas

- **Flutter**: Framework para desarrollar aplicaciones móviles.
- **Firebase**: Plataforma de backend que usamos para la autenticación y la base de datos en tiempo real.
- **FVM**: Flutter Version Management, usado para gestionar la versión de Flutter.
- **Firestore**: Base de datos en la nube de Firebase utilizada para almacenar notas.

## Requisitos previos

### 1. FVM

Esta aplicación usa **Flutter 3.10.1**, gestionado por **FVM**. Si aún no tienes **FVM** instalado, sigue los siguientes pasos:

- Instala **FVM** siguiendo [la documentación oficial de FVM](https://fvm.app/docs/getting_started).
- Después, usa el siguiente comando para asegurarte de que estás usando la versión correcta de Flutter:
  ```bash
  fvm use 3.10.1
  Luego, ejecuta el siguiente comando para instalar las dependencias de la app: fvm flutter pub get



### 2. FIREBASE

---
Yo te proporcionaré el archivo [google-services.json] para que lo agregues al directorio [android/app/] de el proyecto.
