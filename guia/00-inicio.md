# 0 · Antes de empezar

## Tu entorno

- **Arriba**: el editor, donde vas a leer las guías y editar archivos.
- **Abajo**: la terminal, donde vas a escribir los comandos. Si no la ves, abre el menú ☰ › **Terminal** › **New Terminal**.
- **Izquierda**: el explorador de archivos del laboratorio.

Para copiar un comando de esta guía, selecciónalo con el mouse y cópialo con `Ctrl+C` (o `Cmd+C` en Mac). En la terminal, pega con `Ctrl+Shift+V` (o `Cmd+V` en Mac).

> **Tip:** si prefieres un botón de copiar en cada comando, abre la misma guía en GitHub en otra pestaña del navegador: [github.com/alexrod04ag-ctrl/NicaHackFest](https://github.com/alexrod04ag-ctrl/NicaHackFest/tree/main/guia).
>
> Si una guía se abre con símbolos como `**` o `|`, haz clic derecho sobre su pestaña y elige **Open Preview** para verla con formato.

## Cómo está armado el laboratorio

| Papel en 802.1X | En este laboratorio |
|---|---|
| Suplicante (el dispositivo) | `eapol_test`, con los perfiles de la carpeta `clientes/` |
| Autenticador (switch o access point) | `eapol_test` también lo simula: le habla RADIUS al servidor |
| Servidor de autenticación | FreeRADIUS, configurado desde la carpeta `radius/` |
| PKI | OpenSSL, en la carpeta `pki/` |

## El asistente `lab`

Todo se maneja con un comando llamado `lab`. Pruébalo:

```bash
lab ayuda
```

Tres comandos para recordar:

- `lab verificar <n>` revisa si completaste el ejercicio `n`.
- `lab solucion <n>` te pone al día si te atrasaste. No pasa nada si lo usas: lo importante es entender qué pasó.
- `lab reiniciar` aplica los cambios después de editar un archivo de configuración.

Listo. Sigue con el [ejercicio 1](01-radius-aaa.md).
