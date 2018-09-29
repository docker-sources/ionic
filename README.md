# ionic (container Docker)

<p align="center">
	<img alt="logo-docker" class="avatar rounded-2" height="150" src="https://avatars2.githubusercontent.com/u/35675959?s=400&u=b1f9ebca6fa8e5be55cb524e16f38b52f2f1dd58&v=4" width="160">
	<br>
	Travis-CI<br>
	<a href="https://travis-ci.org/docker-sources/ionic">
		<img src="https://travis-ci.org/docker-sources/ionic.svg?branch=master" alt="Build Status">
	</a>
</p>

Essa é uma imagem **docker** criada para start simplificado de aplicações baseadas no Ionic.

As palavras-chave "DEVE", "NÃO DEVE", "REQUER", "DEVERIA", "NÃO DEVERIA", "PODERIA", "NÃO PODERIA", "RECOMENDÁVEL", "PODE", e "OPCIONAL" presentes em qualquer parte deste repositório devem ser interpretadas como descritas no [RFC 2119](http://tools.ietf.org/html/rfc2119). Tradução livre [RFC 2119 pt-br](http://rfc.pt.webiwg.org/rfc2119).

## Imagens disponíveis

Consulte a guia [Tags](https://hub.docker.com/r/fabiojanio/ionic/tags/) no repositório deste projeto no **Docker Hub** para ter acesso a outras versões.

## Pacotes presentes na imagem

 - Nodejs 8.x
 - Ionic 3.20.0
 - Cordova 7.1.0
 - Android SDK 3859397

 > Obs: as versões citadas acima são referentes a compilação atual desta imagem. O script de *build* foi criado de modo a permitir atualizações menores (*minor*) de forma transparente a cada nova *build*.

## Considerações relevantes

 - Porta padrão do Ionic: 8100
 - Porta padrão do livereload: 35729 e 53703

## Start container

Caso já tenha um projeto Ionic, OPCIONALMENTE você pode iniciar um container temporário para testar o aplicativo em modo servidor:

```
docker run --rm -v /myApp/:/app -p 8100:8100 -p 35729:35729 -p 53703:53703 fabiojanio/ionic ionic serve
```

**Obs**: no lugar de *myApp* você DEVE informar o caminho absoluto do diretório a ser compartilhado com o container. Por ser um container temporário o mesmo não foi nomeado.

Caso queira criar um novo container para dá inicio a um projeto Ionic, execute:

```
docker run -it -p 8100:8100 -p 35729:35729 -p 53703:53703 --name nome_do_container fabiojanio/ionic /bin/bash
```

Caso já tenha um container criado anteriormente por meio da instrução `run`, basta executar este comando para iniciar o container:

```
docker start nome_do_container
```

Para se conectar a um container basta executar:

```
docker exec -it nome_do_container /bin/bash
```

### Dica

Caso queira compilar um **apk** para Android, não é necessário conectar no container, basta executar:

```
docker run --rm -v $(pwd):/app fabiojanio/ionic ionic cordova build android --prod
```

Neste caso utilizei `$(pwd)` pois em ambiente unix-like isso é uma referência absoluta para o diretório corrente.


## docker-compose.yml

Para subir o ambiente utilizando o docker-compose, efetue o download do arquivo [**docker-compose.yml**](https://github.com/docker-sources/ionic/blob/master/docker-compose.yml), acesse o diretório onde o arquivo foi baixado e execute:

```
docker-compose run ionic --name nome_do_container bash
```

Para se conectar:

```
docker exec -it nome_do_container /bin/bash
```

## Build (opcional)

Os passos anteriores estão configurados para utilizar a imagem já compilada disponível no **Docker Hub**, entretanto, caso queira compilar sua própria imagem, basta efetuar o download do arquivo [**Dockerfile**](https://github.com/docker-sources/ionic/blob/master/Dockerfile) e executar a instrução:

```
docker build -t nome_da_nova_imagem:nome_da_tag .
```

Para iniciar o container siga os passos contidos no tópico: **Start container**


## Licença MIT

Para maiores informações, leia o arquivo de [licença](https://github.com/docker-sources/php-apache-nodejs/blob/master/LICENSE) disponível neste repositório.