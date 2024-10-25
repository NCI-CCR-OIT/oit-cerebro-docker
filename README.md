oit-cerebro-docker
--------------

oit-cerebro-docker contains a OIT-modified version of the official docker files for [cerebro](https://github.com/lmenezes/cerebro) project.

The specific changes made by OIT are:

* move to Amazon's Coretto Java 11 headless image

### Usage

For using latest cerebro execute:

```
docker run -p 9000:9000 oitrepo.ccr.cancer.gov/oit-cerebro
```

For using a specific version run:

```
docker run -p 9000:9000 oitrepo.ccr.cancer.gov/oit-cerebro:0.9.4
```

### Configuration

You can configure a custom port for cerebro by using the `CEREBRO_PORT` environment variable. This defaults to `9000`.

**Example**
```
docker run -e CEREBRO_PORT=8080 -p 8080:8080 lmenezes/cerebro
```
To access an elasticsearch instance running on localhost:
```
docker run -p 9000:9000 --network=host lmenezes/cerebro
```
