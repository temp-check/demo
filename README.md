# temp-check | Demo

## Installation

This project uses submodules, so you need to clone it with the `--recursive` flag:

```bash
git clone git@github.com:temp-check/demo.git --recursive
```

Or, if you already cloned it, you can run:

```bash
git submodule update --init --recursive
```

:warning: **Don't skip this step :warning: Run this from the root of the project, not from inside the `api` or `web` directories:

```bash

cd api && git submodule update --init --recursive && \
cd ../web && git submodule update --init --recursive && cd ../

```

To launch the application, run:

```bash
docker-compose up
```

## API

Additional documentation for the API can be found [here](https://github.com/temp-check/api).

## Web Client

Additional documentation on the web client can be found [here](https://github.com/temp-check/web).
