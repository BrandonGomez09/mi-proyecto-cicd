# Proyecto de Flujo CI/CD con Docker y AWS

Este proyecto demuestra la configuración de un pipeline de Integración y Despliegue Continuo (CI/CD) para una aplicación Node.js.

---

## 1. Breve Explicación del Pipeline



El pipeline se activa automáticamente con cada `push` a la rama `develop`. El proceso, gestionado por GitHub Actions, sigue estos pasos:
1.  **Construcción (CI):** Se construye una imagen de Docker de la aplicación a partir del `Dockerfile`.
2.  **Publicación (CI):** La nueva imagen se publica en un registro de contenedores (Docker Hub), etiquetada como `latest`.
3.  **Despliegue (CD):** El flujo de trabajo se conecta de forma segura al servidor EC2 en AWS mediante SSH.
4.  **Ejecución (CD):** En el servidor, se detiene y elimina la versión anterior del contenedor de la aplicación. Luego, se descarga la nueva imagen desde Docker Hub y se ejecuta como un nuevo contenedor, pasando las credenciales de la base de datos como variables de entorno.

---

## 2. Descripción de cómo se manejan las migraciones


Para este proyecto, la configuración inicial de la base de datos se realizó como un paso manual único en el servidor EC2. Se utilizó un contenedor de Docker para correr una instancia de MySQL.

Una vez que el contenedor de la base de datos estaba en ejecución, me conecté a él y ejecuté los scripts SQL necesarios para:
1.  Crear la tabla `users`.
2.  Insertar los datos de prueba iniciales.

En un entorno de producción, este proceso se automatizaría utilizando una herramienta de migración (como `db-migrate` para Node.js). El comando para ejecutar las migraciones se añadiría al script de despliegue en el archivo `ci.yml` para que se ejecute antes de iniciar el nuevo contenedor de la aplicación.

---


## 3. Conclusiones Personales

La implementación de este pipeline de CI/CD me permitió comprender la importancia de la automatización en el desarrollo de software. El uso de contenedores con Docker garantiza que la aplicación funcione de la misma manera en cualquier entorno, eliminando el clásico problema de "en mi máquina sí funciona". Aunque la configuración inicial de los secretos y los permisos fue desafiante, los beneficios de poder desplegar nuevas versiones del código con un simple `git push` son inmensos en términos de velocidad y fiabilidad.