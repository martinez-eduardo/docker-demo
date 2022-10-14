# imagen base
FROM golang:1.12-alpine

# Agregamos git, bash y openssh a la imagen
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# Agregamos informacion
LABEL maintainer="Ricardo Valladares <ricardovalladares.migracion@gmail.com>"

# Set the Current Working Directory inside the container
WORKDIR /docker

# Copiamos go.mod
COPY go.mod ./

# Descargamos todas las dependencias. Las dependencias se almacenarán en caché si los archivos go.mod no se modifican.
RUN go mod download

# Copie la fuente del directorio actual al directorio de trabajo dentro del contenedor
COPY . .

# Construimos la aplicacion
RUN go build -o main .

# Exponemos el puerto 8080
EXPOSE 8080

# Ejecutamos la aplicacion
CMD ["./main"]
