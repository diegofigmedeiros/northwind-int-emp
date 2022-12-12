# Inteligencia_Empresarial

## Requerimentos

- SQL Power Arquitect
- Pentaho
- Power BI Desktop

## Pentaho
- Baixar o arquivo [`pdi-ce-8.3.zip`](https://drive.google.com/file/d/1I3m6YnzSEuFl8_PWv7eekW9iWW14ar7t/view)

- Criar diretório do pentaho `C:\Program Files\pentaho`
- Criar diretório `KETTLE_HOME` dentro do diretório do pentaho
- Descompactar o `pdi-ce-8.3.zip` dentro do diretório do pentaho

```
C:/Program Files/pentaho
├───KETTLE_HOME
│   └───.kettle
└───pdi-ce-8.3
    ├───.telemetry
    ├───classes
    ├───Data Integration.app
    ├───Data Service JDBC Driver
    ├───docs
    ├───launcher
    ├───lib
    ├───libswt
    ├───logs
    ├───plugins
    ├───pwd
    ├───samples
    ├───system
    └───ui
```

|Variavel de Ambiente|Caminho|
|---|---|
`JAVA_HOME`| `C:\Program Files\Java\jre1.8.0_351`
`KETTLE_HOME`| `C:\Program Files\pentaho\KETTLE_HOME`

## Iniciando via Script
Mude a variável de ambiente `PATH_DLL_FILE` dentro de `docker-compose.yml` para mudar qual script irá gerar as *dimensões* e *fatos*:

Na raiz do projeto execute o seguinte comando:
```
./exec_down_build_up_docker.bat
```

---

## Iniciando via Docker
Na raiz do projeto, onde há o arquivo `docker-compose.yml`, execute o seguinte comando:
```
docker compose down --volumes
```
Em seguida, realize o build do container com o seguinte comando:
```
docker compose build
```
Em seguida, suba o container com o seguinte comando:
```
docker compose up
```

- Será criado volumes gerenciados pelo próprio **Docker** na sua maquina local, a fim de persistir os dados
- **Postgres** serão iniciados na porta **`6000`**
	- user: **`postgres`**
	- password: **`ifpb`**