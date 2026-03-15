# Протокол архитектурного ревью PR #5 (Перехват синтаксической ошибки CI-линтером)

- **Ветка-источник:** `demo/syntax-violation` -> `main`
- **Автор PR:** Алибеков А. (Back-end архитектор команды 18)
- **Ревьюер:** Бектеев Георгий А. (Тимлид команды 18)
- **Затронутые файлы:**
  - `src/components/backend_components.puml`

---

## Ход проверки и работа автоматического пайплайна

### Итерация 1 — Блокировка сборки пайплайном CI/CD (`exit code 1`)
В коммите `bad: use directional Rel_D in backend_components (triggers CI failure)` автор попытался вручную выровнять связь между `api_router` и `forecast_service` с помощью запрещённого макроса `Rel_D(...)`:

```plantuml
Rel_D(api_router, forecast_service, "Передаёт параметры сценария и запрашивает прогнозные траектории", "Вызов методов Python")
```

При открытии Pull Request скрипт `scripts/validate_and_render.sh` в GitHub Actions обнаружил нарушение регламента репозитория и прервал сборку с кодом возврата `1` (см. полный лог в `docs/images/build_failure.log`):

```text
[FAIL] src/components/backend_components.puml: запрещённые направленные связи Rel_U/D/L/R/Back/Neighbor:
28:Rel_D(api_router, forecast_service, "Передаёт параметры сценария и запрашивает прогнозные траектории", "Вызов методов Python")
==========================================================
 СБОРКА ПРЕРВАНА: обнаружено нарушений синтаксиса: 1
 Исправьте ошибки перед слиянием Pull Request в main.
==========================================================
```

**Резолюция тимлида (Бектеев Г.А.):** *Request Changes* — заменить `Rel_D` на стандартный `Rel`, чтобы не ломать автоматическую раскладку графа Graphviz.

---

### Итерация 2 — Исправление и успешная сборка (`exit code 0`)
В коммите `fix: replace forbidden Rel_D with standard Rel to pass CI linter` автор устранил нарушение:

```plantuml
Rel(api_router, forecast_service, "Передаёт параметры сценария и запрашивает прогнозные траектории", "Вызов методов Python")
```

Повторный запуск `scripts/validate_and_render.sh` завершился успешно (`exit code 0`, все 11 диаграмм репозитория отрендерены в `docs/images/*.png`, см. `docs/images/build_success.log`).

**Решение ревьюера:** Одобрено (Approved) после исправления. Ветка `demo/syntax-violation` влита в `main` (`--no-ff`).
