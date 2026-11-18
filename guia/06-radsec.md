# 6 · Bonus: RadSec (3 min)

**Objetivo:** ver con tus propios ojos por qué RADIUS tradicional no debe cruzar redes que no controlas, y cómo RadSec lo protege.

## Paso 1 · Activa RadSec

```bash
lab radsec
```

Esto emite un certificado para un proxy RadSec y activa dos piezas:

```
 radtest ── UDP 11812 ──> radsecproxy ══ TLS, TCP 2083 ══> FreeRADIUS
```

## Paso 2 · Compara el tráfico

```bash
lab comparar
```

El comando captura el tráfico con `tcpdump` mientras hace dos autenticaciones: una por RADIUS tradicional (UDP 1812) y otra por RadSec (TLS sobre TCP 2083).

## Resultado esperado

- **UDP 1812:** se ve el usuario `ana` y los atributos en texto claro.
- **RadSec:** la autenticación funciona, pero en la captura no aparece nada legible.

¿Quieres verlo tú mismo? Las capturas completas están en `/tmp/zt-lab/udp.txt` y `/tmp/zt-lab/tls.txt`:

```bash
grep -a ana /tmp/zt-lab/udp.txt
grep -a ana /tmp/zt-lab/tls.txt
```

## Verifica

```bash
lab verificar 6
```

## Para pensar

- RADIUS sobre UDP protege su integridad con MD5 y un secreto compartido. El ataque **Blast-RADIUS** (2024) mostró que un atacante en medio puede convertir un Access-Reject en Access-Accept.
- RadSec envuelve todo en TLS con autenticación mutua por certificados. Úsalo siempre que RADIUS cruce redes que no controlas, como un RADIUS en la nube.

---

## ¡Terminaste!

Recorriste el camino completo de Zero Trust en la red: **identidad** con certificados, **autenticación** con 802.1X, **autorización** según quién eres, **revocación** inmediata y **transporte cifrado**.

Al terminar, detén tu codespace en [github.com/codespaces](https://github.com/codespaces) para no gastar horas de más.
