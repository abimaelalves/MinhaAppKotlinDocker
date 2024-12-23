# Documentação: Subir Aplicação Spring Boot com Kotlin

Este guia fornece um passo a passo detalhado para subir a aplicação localmente em um container Docker e testar o endpoint `/actuator/health`.

---

## **1. Pré-requisitos**

- **Docker**: Certifique-se de que o Docker está instalado e funcionando.
- **Java 17 ou superior**: Necessário apenas para testes locais no Windows ou em outro sistema operacional, caso deseje executar localmente.

### **Comandos no Windows (Se necessário):**
Caso você deseje verificar ou instalar o Java 17 no Windows, siga os passos abaixo:

1. Verificar a versão instalada:
   ```cmd
   java -version
   ```
2. Instalar o Java 17 manualmente:
   Baixe e configure o [Amazon Corretto 17](https://corretto.aws/downloads/latest/amazon-corretto-17-x64-windows-jdk.zip).

2. Buildar a aplicação: Navegue até o diretório do projeto e execute:
   ```cmd
   .\gradlew clean build
   ```

3. Subir a aplicação localmente: Execute o JAR gerado pelo build:
   ```cmd
   java -jar build\libs\MinhaAppKotlin-0.0.1-SNAPSHOT.jar
   ```

---

## **2. Subir a Aplicação com Docker**

### **Passo a Passo**

1. **Construa a Imagem Docker:**
   No diretório raiz do projeto, execute:
   ```bash
   docker build -t minha-app-kotlin:1.0 .
   ```

2. **Execute o Container:**
   Suba a aplicação em um container Docker:
   ```bash
   docker run -d -p 8080:8080 --name minha-app-container minha-app-kotlin:1.0
   ```

3. **Verifique se o Container está Rodando:**
   Liste os containers ativos:
   ```bash
   docker ps
   ```
   Confirme que o container está rodando e a porta 8080 está mapeada.

4. **Teste o Endpoint de Health:**
   No navegador ou usando `curl`, acesse:
   ```bash
   curl http://localhost:8080/actuator/health
   ```
   A resposta esperada:
   ```json
   {
     "status": "UP"
   }
   ```

5. **Parar e Remover o Container (Opcional):**
   Para parar o container:
   ```bash
   docker stop minha-app-container
   ```
   Para remover o container:
   ```bash
   docker rm minha-app-container
   ```

---

## **3. Publicação e Distribuição**

### **Publicar no Docker Hub**
1. **Faça Login no Docker Hub:**
   ```bash
   docker login
   ```

2. **Renomeie a Imagem para Incluir Seu Nome de Usuário:**
   ```bash
   docker tag minha-app-kotlin:1.0 seu-usuario-docker/minha-app-kotlin:1.0
   ```

3. **Envie a Imagem para o Docker Hub:**
   ```bash
   docker push seu-usuario-docker/minha-app-kotlin:1.0
   ```

### **Compartilhar o Projeto Localmente**
- Forneça o `README.md` com as instruções.
- Inclua um script de automação para facilitar o build e a execução (ex.: `start.sh` ou `docker-compose.yml`).

