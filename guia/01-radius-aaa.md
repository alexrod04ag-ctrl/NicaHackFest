# 1 · Servidor RADIUS y AAA (3 min)

**Objetivo:** iniciar el servidor RADIUS y ver la autenticación más básica: usuario y contraseña.

## Pasos

1. Inicia el servidor:

   ```bash
   lab iniciar
   ```

2. Envía una solicitud de acceso con `radtest`, una herramienta que simula al switch preguntando "¿dejo entrar a este usuario?":

   ```bash
   radtest ana 'Nica2026!' 127.0.0.1 0 testing123
   ```

   El formato es: `radtest <usuario> <contraseña> <servidor> <puerto NAS> <secreto compartido>`. El *secreto compartido* (`testing123`) es la clave que comparten el switch y el servidor RADIUS.

3. Ahora con una contraseña incorrecta:

   ```bash
   radtest ana 'otra' 127.0.0.1 0 testing123
   ```

## Resultado esperado

- Con la contraseña correcta: `Received Access-Accept`.
- Con la incorrecta: `Received Access-Reject` (tarda un segundo: el servidor retrasa los rechazos a propósito para frenar ataques de fuerza bruta).

## Verifica

```bash
lab verificar 1
```

## Para pensar

- Esto es la **A de Authentication**: ¿quién eres?
- El usuario `ana` está en el archivo `radius/usuarios`. ¿Qué pasa si alguien roba esa contraseña? Eso es lo que vamos a eliminar en los siguientes ejercicios.

Sigue con el [ejercicio 2](02-pki.md).
