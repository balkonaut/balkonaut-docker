<img src="https://raw.githubusercontent.com/balkonaut/balkonaut/main/docs/assets/logo.svg" alt="Balkonaut" width="96" align="right">

# Balkonaut als Docker-App

[![Version](https://img.shields.io/github/v/release/balkonaut/balkonaut-docker)](https://github.com/balkonaut/balkonaut-docker/releases)
[![Lizenz](https://img.shields.io/github/license/balkonaut/balkonaut-docker)](https://github.com/balkonaut/balkonaut-docker/blob/main/LICENSE)
[![Buy me a coffee](https://img.shields.io/badge/Buy%20me%20a%20coffee-balkonaut-FFDD00?logo=buymeacoffee&logoColor=black)](https://buymeacoffee.com/balkonaut)

**Antworten statt Rohdaten für dein Balkonkraftwerk mit Speicher**, als eigenständige Docker-App ohne Home Assistant,
etwa auf einer NAS oder einem Raspberry Pi, mit eigener Weboberfläche. Wer Home Assistant nutzt, ist mit der
[Home-Assistant-Integration](https://github.com/balkonaut/balkonaut) meist einfacher dran.

![Übersicht der Docker-App: Ersparnis, Akku, Autarkie und Energiefluss](https://raw.githubusercontent.com/balkonaut/balkonaut/main/docs/assets/docker.png)

Die Docker-App liest APsystems EZHI, Shelly-Zähler und Shelly Plug, Hoymiles über OpenDTU oder AhoyDTU, Deye über den
Logger-Stick sowie Victron GX (MQTT, Modbus TCP) direkt im Heimnetz und holt Prognose und Jahresverlauf aus Standort
und Flächen. Andere Geräte liest sie über Home Assistant
([Unterstützte Geräte](https://balkonaut.github.io/balkonaut/geraete/)).

## Installation

```yaml
services:
  balkonaut:
    image: ghcr.io/balkonaut/balkonaut-docker:latest
    ports:
      - "${BALKONAUT_PORT:-8000}:8000"
    environment:
      - TZ=${TZ:-Europe/Berlin}
    volumes:
      - ./data:/data
    restart: unless-stopped
```

`docker compose up -d`, dann `http://<adresse>:8000/` öffnen und unter *Einstellungen* die Geräte per IP-Adresse
hinzufügen. Für den APsystems EZHI lässt sich optional die APsystems-Cloud verbinden (nicht offiziell, Nutzung auf
eigenes Risiko, siehe [Handbuch](https://balkonaut.github.io/balkonaut/einstellungen/#apsystems-cloud-optional)).
Alles Weitere im [Handbuch](https://balkonaut.github.io/balkonaut/docker/).

## Selbst bauen

Der gemeinsame Kern und das Handbuch liegen im Repository der
[Home-Assistant-Integration](https://github.com/balkonaut/balkonaut) und gehören beim Bauen in den Ordner `kern/`:

```bash
git clone https://github.com/balkonaut/balkonaut-docker
cd balkonaut-docker
git clone --depth 1 https://github.com/balkonaut/balkonaut kern
docker compose up -d --build   # vorher in docker-compose.yml die Zeile "# build: ." aktivieren
```

Für eine bestimmte Version beide Repositories auf denselben Tag setzen (`git clone --branch v1.0.3 ...`).

## Fehler und Wünsche

Bitte als [Issue bei balkonaut/balkonaut](https://github.com/balkonaut/balkonaut/issues), dort laufen alle Themen
zusammen.

## Lizenz

[Apache-2.0](LICENSE)
