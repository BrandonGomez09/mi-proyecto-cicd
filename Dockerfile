# --- Fase 1: La Base ---
# Usamos una imagen oficial de Node.js como punto de partida.
# La etiqueta "18-alpine" es una versión ligera, lo que hace nuestra imagen final más pequeña.
FROM node:18-alpine

# --- Fase 2: Configuración del Entorno ---
# Creamos un directorio dentro del contenedor para alojar nuestro código.
WORKDIR /app

# --- Fase 3: Instalación de Dependencias ---
# Copiamos solo los archivos que definen las dependencias.
# Al copiarlos primero, Docker puede usar la caché si no han cambiado,
# haciendo que las construcciones futuras sean mucho más rápidas.
COPY package*.json ./
RUN npm install

# --- Fase 4: Copiar el Código de la Aplicación ---
# Ahora copiamos el resto del código de nuestra aplicación al contenedor.
COPY . .

# --- Fase 5: Exponer el Puerto ---
# Le informamos a Docker que nuestra aplicación se ejecutará en el puerto 3000.
# Esto no abre el puerto, solo lo documenta.
EXPOSE 3000

# --- Fase 6: Comando de Arranque ---
# Este es el comando que se ejecutará cuando el contenedor se inicie.
# Le dice a Node.js que ejecute nuestro archivo principal.
CMD ["node", "index.js"]