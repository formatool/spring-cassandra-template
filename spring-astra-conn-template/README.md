# Templates Springboot com conexão ao Astra DB

Template Springboot que conecta ao Astra DB com o _Secure Connect Bundle_ e executa um script de inicialização.

## Preparando Ambiente

Execute o script `/.setup.sh` e siga as instruções.

## Executando

Para executar **sem** o script de inicialização

```
mvn spring-boot:run
```

Para executar **com** o script de inicialização

```
KEYSPACE_POPULATOR=true mvn spring-boot:run
```