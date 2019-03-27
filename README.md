# docker-grafana

## Usage

```bash
docker run \
	--name grafana \
	-p 3000:3000 \
	-v grafana:/etc/grafana \
	spencerhughes/grafana:latest
```

## Mounting an External Volume

If you want to mount persistent external storage to the container, run the following commands:

```bash
docker run --name grafana_tmp spencerhughes/grafana
docker cp ${CONTAINER_ID}:/etc/grafana/* /your/grafana/dir/on/host/
docker container stop grafana
docker container rm grafana_tmp
docker run \
	--name grafana \
	-p 3000:3000 \
	-v /your/grafana/dir/on/host:/etc/grafana \
	spencerhughes/grafana:latest
```