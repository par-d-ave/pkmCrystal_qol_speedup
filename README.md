# Pokémon Crystal – Quality of Life & Engine Speedup Patch

ROM hack basado en el desensamblado [pret/pokecrystal](https://github.com/pret/pokecrystal) de Pokémon Crystal.

El proyecto busca mejorar la velocidad, comodidad y flujo de juego sin alterar innecesariamente las mecánicas originales de segunda generación.

**Prioridad principal:** mantener la compatibilidad con los archivos de guardado (`.sav`) originales.

**Regla fundamental:** ninguna funcionalidad debe implementarse si requiere romper la compatibilidad con las partidas originales.

---

## 🚀 Objetivos

- Combates más rápidos.
- Movimiento más rápido.
- Texto instantáneo.
- Menos esperas artificiales.
- Animaciones y transiciones más rápidas.
- Eventos y NPCs semanales disponibles todos los días.
- Mayor disponibilidad de determinados Pokémon.
- Pequeños ajustes de QoL y balance.
- Compatibilidad con partidas guardadas originales.

La filosofía del proyecto es realizar cambios pequeños y localizados, reutilizando los sistemas existentes siempre que sea posible.

---

## ✨ Características implementadas

### Movimiento ×2

Caminar es aproximadamente ×2 más rápido (4 px por frame durante 4 frames, en lugar de 2 px durante 8). Se mantiene el tamaño de paso de 16 px por casilla.

> Efecto secundario: la bicicleta conserva su velocidad original, por lo que ahora iguala a caminar.

### Texto instantáneo

La opción FAST muestra los textos inmediatamente, eliminando el retraso carácter por carácter.

### Combates acelerados

- **Pausas de combate:** las esperas internas se dividen entre 8, con un mínimo de 4 frames.
- **Animaciones de ataque:** aproximadamente ×5 más rápidas.
- **Barra de EXP:** pasos de 4 píxeles y pausa inicial reducida de 10 a 2 frames.
- **Barra de HP:** avanza 2 píxeles por paso, tanto con daño como con curación.

### Transiciones de combate

- **Animación de inicio de combate:** el efecto radial/de entrada a batalla se ejecuta ×2 más rápido.
- **Entrada del Pokémon salvaje:** el deslizamiento de izquierda a derecha es ×2 más rápido.

### Guardado

- Esperas artificiales reducidas a 2 frames.
- Los mensajes de guardado se muestran en velocidad FAST.
- Se elimina la confirmación al sobrescribir **tu propia** partida. Se mantiene el aviso si el `.sav` pertenece a otro jugador.

### DVs y shiny

- Los Pokémon salvajes nacen con DVs máximos.
- Probabilidad de shiny de 1/5 (shiny legal).
- Unown queda excluido, porque su letra depende de los DVs.
- Huevos y Pokémon de regalo mantienen DVs aleatorios.

### Eventos y NPCs sin día de la semana

Disponibles todos los días, con sus regalos en cantidad ×99:

| Día original | NPC |
|---|---|
| Lunes | Monica |
| Martes | Tuscany (requiere la Medalla Céfiro, como en el original) |
| Miércoles | Wesley |
| Jueves | Arthur |
| Viernes | Frieda |
| Sábado | Santos |
| Domingo | Sunny |

Además:

- Concurso de Bichos disponible todos los días.
- Lapras sin comprobación de día.
- Azotea del Goldenrod Dept. Store siempre activa.
- GS Ball no necesaria; el evento de Celebi queda disponible tras Ho-Oh.

> La peluquería y Gramps del subterráneo de Goldenrod mantienen su comportamiento original.

### Objetos y captura

- Heavy Ball y Moon Ball ajustadas al ratio de la Ultra Ball.
- Apricorns en Kurt ×99.

### Huevos

Los tiempos de aparición y eclosión de los huevos se dividen entre 10.

### Evoluciones

Las evoluciones por intercambio, incluidas las que requieren objeto, pasan a ocurrir por nivel 36.

### Encuentros

- **Mt. Silver (exterior):** añadidos Mareep, Remoraid y Girafarig.
- **Mt. Silver (Silver Cave):** los iniciales (Cyndaquil, Totodile y Chikorita) aparecen como salvajes.
- **Roamers:** Entei siempre está en la Ruta 29 y Raikou en la Ruta 30, mientras estén activos y no hayan sido capturados. Se mantiene su probabilidad de aparición original.

---

## 🔒 Compatibilidad con .sav

La compatibilidad con partidas originales es la principal restricción técnica del proyecto.

Se evita modificar:

- Estructuras de Pokémon.
- Party y Pokémon almacenados en cajas.
- RAM/SRAM persistente.
- Layout y formato de los saves.
- Offsets y tamaños de estructuras existentes.

La única variable nueva (`wBattleAnimSpeedTick`) está en WRAM banco 5, una zona que no se guarda.

Se priorizan modificaciones de delays, constantes, tablas y rutinas existentes.

Si una funcionalidad requiere modificar la estructura o interpretación de los datos persistentes, debe buscarse una alternativa o descartarse.

---

## 🛠️ Tecnologías

- Game Boy Assembly / LR35902
- pret/pokecrystal
- RGBDS
  - `rgbasm`
  - `rgblink`
  - `rgbfix`
- `make`
- `git`

Desarrollo realizado actualmente sobre WSL2 + Ubuntu.

---

## 📦 Compilación

### Requisitos

En Ubuntu/Debian/WSL:

```bash
sudo apt update
sudo apt install build-essential git rgbds
```

### Obtener el proyecto

```bash
git clone https://github.com/par-d-ave/pkmCrystal_qol_speedup.git
cd pkmCrystal_qol_speedup
```

### Compilar

```bash
make
```

El resultado es `pokecrystal.gbc`.

---

## 🧪 Pruebas

Cada cambio debe comprobar:

1. Compilación correcta.
2. Inicio normal del juego.
3. Funcionamiento de la característica modificada.
4. Funcionamiento de las mecánicas no afectadas.
5. Guardado y carga correctos.

Cuando sea relevante, también debe comprobarse una partida `.sav` original antes y después del cambio. No se deben reutilizar savestates del emulador creados con builds anteriores.

---

## 📋 Estado

| # | Característica | Estado |
|---|---|---|
| 1 | Movimiento ×2 | ✅ |
| 2 | Texto FAST instantáneo | ✅ |
| 3 | Pausas y animaciones de combate | ✅ |
| 4 | Barras de EXP y HP aceleradas | ✅ |
| 5 | Transición de inicio y entrada del salvaje ×2 | ✅ |
| 6 | Guardado rápido y sin confirmación propia | ✅ |
| 7 | DVs máximos y shiny 1/5 | ✅ |
| 8 | NPCs semanales disponibles todos los días | ✅ |
| 9 | Concurso de Bichos, Lapras y azotea sin día | ✅ |
| 10 | GS Ball no necesaria y Celebi tras Ho-Oh | ✅ |
| 11 | Heavy/Moon Ball como Ultra Ball | ✅ |
| 12 | Apricorns ×99 en Kurt | ✅ |
| 13 | Huevos ÷10 | ✅ |
| 14 | Evoluciones por intercambio → nivel 36 | ✅ |
| 15 | Mareep, Remoraid y Girafarig en Mt. Silver | ✅ |
| 16 | Iniciales en Silver Cave | ✅ |
| 17 | Entei en Ruta 29 y Raikou en Ruta 30 | ✅ |

---

## ⚠️ Prioridad de desarrollo

1. Compatibilidad con saves originales
2. Integridad de las estructuras existentes
3. Funcionamiento correcto del juego
4. Mantener las mecánicas originales
5. Quality of Life
6. Nuevas funcionalidades

La compatibilidad con partidas originales siempre tiene prioridad.

---

## 📄 Licencia y base del proyecto

Este proyecto utiliza como base el desensamblado [pret/pokecrystal](https://github.com/pret/pokecrystal).

Para obtener información sobre el proyecto original, su licencia y sus condiciones de uso, consultar el repositorio oficial.
