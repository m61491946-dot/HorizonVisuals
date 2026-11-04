# HorizonVisuals

Fabric-клиент для Minecraft **1.21.11** (Fabric Loader 0.19.5, Fabric API 0.141.6).
Визуальная база: кастомный рендер (шейдеры скруглений/теней/блюра), свой шрифт Inter,
Click GUI, HUD с редактором, менеджер аккаунтов и конфиг.

> Внутренний id мода — `svintusclient` (namespace ассетов и ключей переводов),
> чтобы не ломать существующие ресурсы и конфиги.

## Требования

- **JDK 25** — обязателен: Fabric Loom 1.18 не запускается на Java 21 и ниже.
  Скачать: <https://adoptium.net/temurin/releases/?version=25>
- Интернет при первом запуске (скачиваются Minecraft, маппинги и Fabric API).

Если JDK 25 нет в `JAVA_HOME`/`PATH`, Gradle сам скачает его (в проекте включён
`gradle/gradle-daemon-jvm.properties` + Foojay toolchain resolver).

## Запуск

Дважды кликнуть по файлу в папке проекта:

| Файл        | Что делает                                              |
|-------------|---------------------------------------------------------|
| `run.bat`   | Собирает и запускает клиент (dev-запуск, ник `lowcode`) |
| `build.bat` | Собирает мод → `build\libs\HorizonVisuals-1.0.jar`       |

Из терминала (если в `JAVA_HOME` уже JDK 25):

```bat
gradlew.bat runClient     :: запустить игру
gradlew.bat build         :: собрать мод
```

`run.bat` / `build.bat` сами ищут JDK 25 в стандартных местах установки,
поэтому настраивать `JAVA_HOME` вручную не нужно.

## Установка в обычный Minecraft

1. Установить [Fabric Loader 0.19.5](https://fabricmc.net/use/) для Minecraft 1.21.11.
2. Положить `build\libs\HorizonVisuals-1.0.jar` и
   [Fabric API 0.141.6+1.21.11](https://modrinth.com/mod/fabric-api) в папку `mods`.

## Генерация данных (datagen)

```bat
gradlew.bat runDatagen
```

Генерирует `src/main/generated/` — сейчас это `assets/svintusclient/lang/en_us.json`
и `ru_ru.json`. Строки переводов задаются в
`src/main/java/com/lowcode/svintusclient/datagen/SvintusClientLanguageProvider.java`.
JSON-файлы в `src/main/generated` руками не редактируются — они перезаписываются
при каждом запуске. После изменения провайдера запусти `runDatagen` и закоммить
обновлённые файлы.

## Управление

- **Right Shift** — открыть/закрыть Click GUI.
- **Right Alt** — менеджер аккаунтов (или кнопка **Аккаунты** в футере Click GUI).
- **ПКМ по модулю** — настройки, **ЛКМ** — включить/выключить.
- **Чат** — режим редактора HUD: ЛКМ двигает, колесо меняет размер,
  ПКМ открывает настройки элемента, **Ctrl** включает прилипание к краям.

## Аккаунты (Alt Manager)

Оффлайн-аккаунты: ник + UUID, который выводится из ника (`OfflinePlayer:<ник>`).

- Ник вводится в поле, **Enter** — добавить, ещё один **Enter** — войти выбранным.
- **Двойной клик** по строке или кнопка **Войти** — переключить сессию.
- **×** — удалить аккаунт (активный удалить нельзя).
- Сессия меняется без перезапуска игры. Если ты в мире — клиент выйдет в главное
  меню: имя и профиль уже отправлены серверу при подключении.
- Аккаунты и текущий профиль хранятся в `config/svintusclient-alts.json`.

Ограничение: это оффлайн-режим. Для серверов с `online-mode=true` нужен
премиум-аккаунт с токеном Microsoft — такая авторизация сюда не входит.

## Конфиг

`config/svintusclient.json` (в dev-запуске — `run/config/`): тема, состояние модулей,
бинды, настройки и позиции элементов HUD. Сохраняется при закрытии GUI/редактора и выходе из игры.
Аккаунты — в `config/svintusclient-alts.json`.

## Заметки

- Проект лежит в OneDrive — Loom предупреждает, что это замедляет сборку и может
  приводить к блокировкам файлов. Лучше перенести папку вне OneDrive.
- В IDE (IntelliJ IDEA / VS Code) укажи **Gradle JVM = JDK 25**, иначе импорт
  проекта упадёт с ошибкой «Dependency requires at least JVM runtime version 25».
