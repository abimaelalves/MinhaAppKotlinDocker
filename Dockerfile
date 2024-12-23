# Etapa 1: Construção do JAR
# Usamos a imagem gradle com JDK 17 e Amazon Linux 2023
FROM gradle:jdk17-corretto-al2023 AS build

# Define o diretório de trabalho para a fase de build
WORKDIR /app

# Copia apenas os arquivos necessários para o Gradle funcionar
COPY . .

# Concede permissão de execução ao Gradle Wrapper
RUN chmod +x ./gradlew

# Copia o restante dos arquivos do projeto
COPY . .

# Executa o Gradle para construir o JAR da aplicação, ignorando os testes
RUN ./gradlew clean build -x test

# Etapa 2: Execução do JAR
# Usamos uma imagem mais leve para rodar o JAR
FROM amazoncorretto:17-alpine

# Define o diretório de trabalho para a fase de execução
WORKDIR /app

# Copia o JAR gerado na fase de build para a imagem final
COPY --from=build /app/build/libs/*.jar app.jar

# Expõe a porta 8080 para comunicação
EXPOSE 8080

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]