# Kamal-Maintenance

Kamal-Maintenance is an accessory designed to simplify the process of transitioning a web application into and out of maintenance mode. By default, it displays `web/maintenance.html`, but you can also use a custom `.html` file. 

If you need assistance setting it up, feel free to reach out to me on the Kamal Discord server at https://discord.gg/Tjx4eFARxT. My username is @acidtib.

## Using Kamal-Maintenance

To use Kamal-Maintenance, add 'maintenance' as an accessory in your `deploy.yml` file:
```
accessories:
  maintenance:
    image: ghcr.io/acidtib/kamal-maintenance:latest
    roles:
      - web
    env:
      clear:
        HEALTHCHECK_PATH: /up
        LOGS_ENABLED: true
    labels:
      traefik.http.routers.kamal-maintenance.rule: PathPrefix(`/`)
      traefik.http.routers.kamal-maintenance.priority: 99
    files:
      - public/maintenance.html:/usr/share/caddy/index.html
```

## Environment Variables

| Variable | Default Value |
| --- | --- |
| HEALTHCHECK_PATH | /up |
| LOGS_ENABLED | false |


`HEALTHCHECK_PATH`
Sets a healthcheck path that'll respond with a static "200 OK"

---

To enable maintenance mode, use the following command:
```
kamal accessory boot maintenance
```

To disable maintenance mode, use the following command:
```
kamal accessory remove maintenance
```

To view logs, use the following command:
```
kamal accessory logs maintenance -f
```

To use a custom `html` file, place the file in your project directory and update `deploy.yml`.
```
accessories:
  maintenance:
    image: ghcr.io/acidtib/kamal-maintenance:latest
    ************
    files:
      - public/maintenance.html:/usr/share/caddy/index.html
```

This project was inspired by this conversation: https://github.com/basecamp/kamal/issues/162

## Feedback and Contributions

We encourage feedback and contributions from the community. If you have suggestions or would like to contribute to the project, please feel free to open an issue or submit a pull request.
