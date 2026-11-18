# 3 · PEAP-MSCHAPv2 vs. EAP-TLS (8 min)

**Objetivo:** conectar dos dispositivos con 802.1X, uno con contraseña y otro con certificado, y comparar qué ve el servidor.

## Paso 1 · Con contraseña: PEAP-MSCHAPv2

Mira el perfil del dispositivo de ana en `clientes/peap-ana.conf`. Fíjate en la línea `password=`: la contraseña vive en el dispositivo.

```bash
lab probar peap-ana
```

## Paso 2 · Con certificado: EAP-TLS

Mira el perfil `clientes/laptop.conf`. No hay contraseña: solo el certificado y su clave privada.

```bash
lab probar laptop
```

## Resultado esperado

Ambos reciben **ACCESO PERMITIDO**, pero la sección *"Lo que vio el servidor RADIUS"* es distinta:

| | PEAP-MSCHAPv2 | EAP-TLS |
|---|---|---|
| Identidad | `anonymous` afuera, `ana` dentro del túnel | El certificado `laptop-01.lab` |
| Prueba de identidad | Una contraseña | Una clave privada que nunca se transmite |
| Si roban lo que se usa para entrar | El atacante entra desde cualquier lado | No hay contraseña que robar |

Si quieres ver todo el intercambio EAP en el servidor:

```bash
lab logs 120
```

## Verifica

```bash
lab verificar 3
```

## Para pensar

- En PEAP, el túnel TLS solo usa el certificado **del servidor**. Si el dispositivo no valida ese certificado (línea `ca_cert`), un access point falso puede capturar el intercambio MSCHAPv2 y crackear la contraseña.
- Windows 11 ya bloquea el inicio de sesión automático con MSCHAPv2. El camino es EAP-TLS.
- La laptop ya recibió la **VLAN 10**. ¿Y la cámara? Pruébala con `lab probar camara`: ese es el ejercicio 4.

Sigue con el [ejercicio 4](04-autorizacion.md).
