# 4 · Autorización por certificado (5 min)

**Objetivo:** que el servidor RADIUS decida la VLAN de cada dispositivo según su certificado. Autenticar no basta: también hay que decidir **qué puede hacer** cada uno.

## Paso 1 · Mira el problema

```bash
lab probar camara
```

La cámara entra, pero queda en la **VLAN 99 (cuarentena)**: la política no sabe qué hacer con un dispositivo IoT.

## Paso 2 · Edita la política

Abre el archivo `radius/vlan_por_certificado` en el editor (explorador de la izquierda › carpeta `radius`).

- La primera regla ya existe: si el certificado dice `OU=Corporativo`, VLAN 10.
- Busca el bloque marcado **Ejercicio 4**: son 8 líneas que empiezan con `#`.
- Borra el `#` al inicio de esas 8 líneas. Guarda con `Ctrl+S` (o `Cmd+S`).

Debe quedar así:

```
		elsif (&TLS-Client-Cert-Subject =~ /OU=IoT/) {
			update reply {
				&Tunnel-Type := VLAN
				&Tunnel-Medium-Type := IEEE-802
				&Tunnel-Private-Group-Id := "30"
				&Reply-Message := "Dispositivo IoT: VLAN 30 (aislada)"
			}
		}
```

## Paso 3 · Aplica y prueba

```bash
lab reiniciar
lab probar camara
lab probar laptop
```

Si `lab reiniciar` muestra un error, te dice el archivo y la línea: revisa que quitaste los 8 `#` completos.

## Resultado esperado

- `laptop` → VLAN **10** (producción)
- `camara` → VLAN **30** (IoT aislada)

## Verifica

```bash
lab verificar 4
```

## Para pensar

- Esto es la **A de Authorization** y el principio de **mínimo privilegio**: la cámara no tiene por qué ver los servidores de la empresa.
- La decisión sale del certificado, no del puerto donde se conectó. Si la cámara se conecta en otro puerto, sigue en su VLAN.
- En el switch real, los atributos `Tunnel-*` le dicen en qué VLAN poner el puerto.

Sigue con el [ejercicio 5](05-revocacion.md).
