# DemoScope — Архитектурный репозиторий (Diagrams-as-Code, Команда 18)

Репозиторий содержит полное архитектурное описание информационной системы **DemoScope** (*«Информационная система аналитического мониторинга и прогнозирования динамики населения РФ»*), разработанное по методологии **C4 Model** с применением подхода **Diagrams-as-Code** (PlantUML + Git + GitHub Actions CI/CD).

---

## Состав команды 18 (группа ИДБ-23-13)

| Участник | Роль в команде | Зона ответственности в репозитории | Ветка разработки |
|---|---|---|---|
| **Бектеев Георгий А.** | Тимлид / Системный архитектор | Каркас репозитория, глоссарий ID, L1 Context, L2 Containers, мастер-диаграмма `main.puml`, CI/CD пайплайн, Code Review всех PR | `main` |
| **Алибеков А.** | Back-end архитектор | Декомпозиция серверного контейнера `api_backend` (Level 3) и диаграмма классов `forecast_service` (Level 4, паттерн Strategy) | `feature/backend-components`, `demo/syntax-violation` |
| **Слисаренко Дарья** | Front-end архитектор | Декомпозиция клиентского контейнера `web_app` (Level 3) и диаграмма классов `heatmap_styler` (Level 4, паттерн Strategy) | `feature/frontend-components` |
| **Лиджиев Э.С.** | Технический писатель / Клиентский контур | Специализированная диаграмма клиентского контура `web_client.puml`, документация интерфейсов и проверка трассируемости | `feature/web-client` |
| **Сырлыбаев Б.С.** | Системный аналитик / DevOps-архитектор | Системный ландшафт (Level 0), динамическая диаграмма сценария прогноза, диаграмма развертывания в Yandex Cloud | `feature/landscape-infra` |

---

## Структура репозитория

```text
repo/
├── .github/workflows/render-docs.yml     # CI/CD-пайплайн валидации и рендера
├── README.md                             # правила работы, Branch Protection Rules
├── ci_local_build.sh                     # локальная эмуляция шагов пайплайна
├── build_success.log / build_failure.log # логи прогонов сборки
├── src/
│   ├── main.puml                         # сводная диаграмма контейнеров (мастер-файл)
│   ├── context/context_l1.puml           # L1 — системный контекст (Бектеев Г.А.)
│   ├── containers/
│   │   ├── teamlead_containers.puml      # L2 — полная диаграмма контейнеров (Бектеев Г.А.)
│   │   └── web_client.puml               # L2 — клиентский контур (Лиджиев Э.С.)
│   ├── components/
│   │   ├── backend_components.puml       # L3 — компоненты api_backend (Алибеков А.)
│   │   └── frontend_components.puml      # L3 — компоненты web_app (Слисаренко Д.)
│   ├── code/
│   │   ├── class_diagram.puml            # L4 — классы forecast_service (Алибеков А.)
│   │   └── frontend_classes.puml         # L4 — классы heatmap_styler (Слисаренко Д.)
│   └── landscape/
│       ├── landscape_l0.puml             # L0 — системный ландшафт (Сырлыбаев Б.С.)
│       ├── dynamic_process.puml          # Dynamic — сценарий прогноза (Сырлыбаев Б.С.)
│       └── deployment.puml               # Deployment — инфраструктура (Сырлыбаев Б.С.)
├── docs/
│   ├── images/*.png                      # 11 артефактов сборки (обновляются CI/CD)
│   └── GLOSSARY.md                       # единый глоссарий глобальных ID
└── reviews/                              # протоколы Code Review Тимлида по PR1–PR5
```

---

## Правила репозитория и Branch Protection Rules

Для ветки `main` действуют следующие правила защиты (GitHub Settings -> Branches -> Branch protection rules):
- **Require a pull request before merging**: прямое слияние без PR запрещено; требуется минимум 1 одобрение (Approve) от Тимлида команды (`Бектеев Г.А.`).
- **Require status checks to pass before merging**: обязательна успешная проверка `validate-and-render` из `.github/workflows/render-docs.yml`.
- **Запрет жёсткого позиционирования**: в C4-диаграммах разрешены только стандартные вызовы `Rel(...)` и `RelIndex(...)`. Любые макросы `Rel_U`, `Rel_D`, `Rel_L`, `Rel_R` блокируются линтером CI со статусом `CRITICAL FAILURE ❌`.
- **Запрет ручной стилизации в C4**: директивы `skinparam` запрещены во всех C4-диаграммах (разрешены только для UML-диаграмм классов L4 в `src/code/`).
- **Единство глоссария**: все идентификаторы элементов обязаны строго соответствовать `docs/GLOSSARY.md`.
