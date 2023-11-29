# temp-check | Demo

## Installation

To install the application, run:

```bash
git clone git@github.com:temp-check/demo.git
```

To launch the application, run:

```bash
docker-compose up -d
```

This will run in production mode and over ssl, the first time you access you'll see a wanring about the certificate being invalid. This is because the certificate is self signed. To get around this, you can either add the certificate to your trusted certificates.

You may also need to add the following to your `/etc/hosts` file:

```
127.0.0.1 lvh.me
```

And then navigate to [https://lvh.me](https://lvh.me).

To stop the application, run:

```bash
docker-compose down
```

## API

Additional documentation for the API can be found [here](https://github.com/temp-check/api).

## Web Client

Additional documentation on the web client can be found [here](https://github.com/temp-check/web).
