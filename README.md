# Laboratorio Zero Trust · NicaHackfest

Laboratorio práctico del taller **Zero Trust: de la teoría a la red** (NicaHackfest, comunidad NicaSecurity).

Vas a construir el control de acceso a la red de una organización: crear tu propia PKI, levantar un servidor RADIUS, autenticar dispositivos con **802.1X**, comparar **contraseñas vs. certificados**, asignar una **VLAN según la identidad**, **revocar** un dispositivo y proteger RADIUS con **RadSec**.

[![Abrir en GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/alexrod04ag-ctrl/NicaHackFest?quickstart=1)

```
 [ Dispositivo ]  ── 802.1X / EAP ──  [ Servidor RADIUS ]  ←──  [ Tu PKI ]
   eapol_test                           FreeRADIUS               CA y certificados
```

No necesitas un switch ni un access point: `eapol_test` simula el cliente 802.1X del dispositivo (el suplicante) y habla directamente con el servidor RADIUS.

---

## Cómo empezar (recomendado: en el navegador)

1. Crea una cuenta gratuita en [github.com](https://github.com/signup) si no tienes una.
2. Haz clic en el botón **Abrir en GitHub Codespaces** de arriba y luego en **Create codespace**.
3. Espera 1 o 2 minutos mientras se prepara el entorno. Se abre un editor con una terminal abajo.
4. Abre la guía [`guia/00-inicio.md`](guia/00-inicio.md) y sigue los pasos.

Funciona igual en Windows, macOS, Linux o Chromebook: solo necesitas un navegador. No se instala nada en tu laptop.

> **Costo:** las cuentas personales gratuitas de GitHub incluyen horas mensuales de Codespaces. Este laboratorio usa alrededor de una hora. Al terminar, detén o borra tu codespace en [github.com/codespaces](https://github.com/codespaces) para no gastar horas de más.

### Alternativa: en tu laptop con Docker

```bash
git clone https://github.com/alexrod04ag-ctrl/NicaHackFest.git
cd NicaHackFest
docker build -t zt-lab .devcontainer
docker run -it --rm -v "$PWD":/lab -w /lab zt-lab
```

Dentro del contenedor, escribe `lab bienvenida` y sigue la guía.

---

## Ejercicios

| # | Ejercicio | Concepto del taller | Tiempo |
|---|---|---|---|
| 1 | [Servidor RADIUS y AAA](guia/01-radius-aaa.md) | AAA | 3 min |
| 2 | [Crear tu PKI](guia/02-pki.md) | Passwordless con certificados | 7 min |
| 3 | [PEAP-MSCHAPv2 vs. EAP-TLS](guia/03-peap-vs-eaptls.md) | Métodos EAP | 8 min |
| 4 | [Autorización por certificado](guia/04-autorizacion.md) | Mínimo privilegio | 5 min |
| 5 | [Revocar un dispositivo](guia/05-revocacion.md) | Ciclo de vida | 4 min |
| 6 | [Bonus: RadSec](guia/06-radsec.md) | RADIUS protegido con TLS | 3 min |

¿Te atrasaste? `lab solucion <n>` te pone al día hasta el ejercicio `n`. ¿Quieres revisar tu trabajo? `lab verificar <n>`.

## Comandos del laboratorio

| Comando | Qué hace |
|---|---|
| `lab iniciar` | Inicia el servidor RADIUS |
| `lab reiniciar` | Reinicia el servidor después de editar un archivo |
| `lab probar <perfil>` | Simula un dispositivo: `peap-ana`, `laptop` o `camara` |
| `lab logs` | Muestra el registro del servidor (`lab logs -f` para verlo en vivo) |
| `lab verificar <n>` | Revisa si completaste el ejercicio `n` |
| `lab solucion <n>` | Te pone al día hasta el ejercicio `n` |
| `lab reset` | Borra tu PKI y empieza de cero |

---

## Aviso

Este laboratorio es **solo para aprendizaje**. Usa claves, contraseñas y certificados de prueba, ejecuta FreeRADIUS como root dentro del contenedor y simplifica la configuración. No lo uses tal cual en producción.

Componentes: [FreeRADIUS](https://freeradius.org), `eapol_test` de [wpa_supplicant](https://w1.fi/wpa_supplicant/), [radsecproxy](https://radsecproxy.github.io) y OpenSSL, sobre Ubuntu 24.04.
