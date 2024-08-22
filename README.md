## Example of Ansible role for V2Fly & Shadowsocks deployment

- **V2Fly** – a platform for building proxies to bypass network restrictions and government censorship
- **teddysun/shadowsocks-rust** – an implementation of Shadowsocks protocol written in Rust aiming for the same goals

### Prerequirements

In order to use TLS (secure and ecrypted) connection of V2Fly you should have a pair of X.509 public certificate key and correspoinding private key both encoded in `.PEM` format.

You can use self-signed certificates that are put in trusted stores of all the devices which establish connection to your machine running V2Fly OR you can use domain-validated certificates issued by certificate authority such as Let's Encrypt or other.

In any way you are to have both private key and x.509 (fullchain) files, pathes to which are specified in `certificate` sections of v2Fly configuration file.

Personally, I prefer to use domain-validated wildcard certificate obtained with the help of interactive [certbot](https://eff-certbot.readthedocs.io/en/latest/) utility. Therefore, the role is configured for that approach.

### Configuration

1. Keep your generated key and issued wildcard certificate in a [default certbot directory](https://eff-certbot.readthedocs.io/en/latest/using.html#where-are-my-certificates).
2. Make sure you have an A-type DNS record for your domain that points to your virtual machine's IP.
3. Specify ports and passwords in `vars/main.yml` or leave it as they are. Remember to change `domain` to your domain name. Be cautious as V2Fly passwords MUST be in a form of [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier). You might use this [tool](https://www.uuidgenerator.net/version4) to generate yours:
	- It is up to you to set the number of clients (users) that will be able to connect.
	- Do not use the same v2Fly password for two or more clients.
	- Shadowsocks password is one for every client and SHOULD be as long as possible to avoid [brute-force](https://en.wikipedia.org/wiki/Brute-force_attack) attacks.
4. Donwload client application:
	- [Nekoray](https://github.com/MatsuriDayo/nekoray) for Windows/Linux/MacOS.
	- [v2rayNG](https://github.com/2dust/v2rayNG) for Android.
	- [FoXray](https://apps.apple.com/us/app/foxray/id6448898396)  for iOS.
5. Import client configurations from strings below (each client application has an option to import profile-configuration from clipboard):
```
trojan://f6e5d4e5-290c-4e68-aa62-0bd6150b7812@trojan-tcp.v2fly-is-amazing.com:55998?security=tls&sni=trojan-tcp.v2fly-is-amazing.com&fp=chrome&type=tcp#Trojan%20TCP
```
```
trojan://f6e5d4e5-290c-4e68-aa62-0bd6150b7812@trojan-ws.v2fly-is-amazing.com:55999?security=tls&sni=trojan-ws.v2fly-is-amazing.com&fp=chrome&type=ws&host=trojan-ws.v2fly-is-amazing.com#Trojan%20WS
```
```
vmess://eyJhZGQiOiJ2bWVzcy10Y3AudjJmbHktaXMtYW1hemluZy5jb20iLCJhaWQiOiIwIiwiaG9zdCI6InZtZXNzLXRjcC52MmZseS1pcy1hbWF6aW5nLmNvbSIsImlkIjoiZjZlNWQ0ZTUtMjkwYy00ZTY4LWFhNjItMGJkNjE1MGI3ODEyIiwibmV0IjoidGNwIiwicGF0aCI6IiIsInBvcnQiOiI1NTk5NiIsInBzIjoiVk1FU1MgVENQIiwic2N5IjoiYXV0byIsInNuaSI6InZtZXNzLXRjcC52MmZseS1pcy1hbWF6aW5nLmNvbSIsInRscyI6InRscyIsInR5cGUiOiIiLCJ2IjoiMiJ9
```
```
vmess://eyJhZGQiOiJ2bWVzcy13cy52MmZseS1pcy1hbWF6aW5nLmNvbSIsImFpZCI6IjAiLCJob3N0Ijoidm1lc3Mtd3MudjJmbHktaXMtYW1hemluZy5jb20iLCJpZCI6ImY2ZTVkNGU1LTI5MGMtNGU2OC1hYTYyLTBiZDYxNTBiNzgxMiIsIm5ldCI6IndzIiwicGF0aCI6IiIsInBvcnQiOiI1NTk5NyIsInBzIjoiVk1FU1MgV1MiLCJzY3kiOiJhdXRvIiwic25pIjoidm1lc3Mtd3MudjJmbHktaXMtYW1hemluZy5jb20iLCJ0bHMiOiJ0bHMiLCJ0eXBlIjoiIiwidiI6IjIifQ==
```
```
ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpXdDBHdGszZnlJalBJbUdrTF9PQ09SWlRQM3hsaE5SN2JoR3V5elY4@v2fly-is-amazing.com:55962#Shadowsocks
```
These are **client** configuration strings which will serve you as a startup point. You **MUST** change the passwords, ports and domains after you've imported them so that they correspond to the ones specified in `vars/main.yml`.

You can find more details at [V2Fly.org](https://www.v2fly.org/)