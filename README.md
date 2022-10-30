# Inteligencia_Empresarial

## Requerimentos

### SQL Power Arquitect

### Power BI Desktop

## Iniciando via Docker
Na raiz do projeto, onde há o arquivo `docker-compose.yml`, execute o seguinte comando:
```
docker compose build
```
Em seguida, suba o container com o seguinte comando:
```
docker compose up
```

- Será criado volumes gerenciados pelo próprio **Docker** na sua maquina local, a fim de persistir os dados
- **Postgres** serão iniciados na porta **`6000`**
	- user: **`ifpb`**
	- password: **`ifpb`**