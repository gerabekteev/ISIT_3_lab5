# Глоссарий идентификаторов архитектуры (Glossary IDs)

> **Статус:** Утверждено Тимлидом команды 18 (Бектеев Г.А.).  
> Все участники команды обязаны использовать **строго эти идентификаторы** во всех файлах `src/**/*.puml`. Отклонение от глоссария приводит к блокировке Pull Request на этапе Code Review.

---

## 1. Пользователи (Person) — Level 0 / Level 1 / Level 2 / Level 3

| ID | Название | Роль в системе |
|---|---|---|
| `analyst` | Демограф-аналитик | Основной пользователь: анализирует показатели, строит прогнозы и сравнивает территории |
| `official` | Сотрудник органа гос. управления | Потребитель аналитики: использует «радар проблем» и аналитические отчёты |
| `researcher` | Исследователь / студент | Изучает демографическую динамику регионов РФ и выгружает справки |

---

## 2. Целевая система и внешние системы (System / System_Ext) — Level 0 / Level 1

| ID | Название | Контур | Назначение |
|---|---|---|---|
| `demoscope` | DemoScope | Корпоративный контур (`gov_contour`) | Проектируемая ИС аналитического мониторинга и прогнозирования динамики населения РФ |
| `esia` | ЕСИА (IAM) | Корпоративный контур (`gov_contour`) | Единая система идентификации и аутентификации (SSO, OAuth 2.0 / OIDC) |
| `crm` | Система обращений граждан (CRM) | Корпоративный контур (`gov_contour`) | Ведомственная CRM: регистрация обращений и запрос аналитических справок по gRPC |
| `rosstat` | Росстат | Внешний контур | Федеральная служба государственной статистики (официальные демографические ряды) |
| `emiss` | ЕМИСС | Внешний контур | Единая межведомственная информационно-статистическая система |
| `gemini_api` | Google Gemini API | Внешний контур | Внешний LLM-сервис для генерации аналитических заключений |
| `gdrive` | Google Drive | Внешний контур | Облачное хранилище исходных архивов демографических данных (CSV) |
| `billing` | Биллинг облачного провайдера | Внешний контур | Внешняя финансовая система учёта потребления и оплаты облачных ресурсов |
| `gis_service` | Картографический тайл-сервис | Внешний контур | Внешний провайдер векторных подложек (MVT / GeoJSON) для ГИС-карты регионов |

---

## 3. Контейнеры системы (Container / ContainerDb) — Level 2

| ID | Название | Технология | Ответственный в команде 18 |
|---|---|---|---|
| `web_app` | Веб-приложение (SPA) | React 19, TypeScript, Vite, Tailwind CSS | Слисаренко Д. (Front-end), Лиджиев Э.С. (Tech-doc) |
| `mobile_app` | Мобильное приложение | React Native, TypeScript | Лиджиев Э.С. (Tech-doc) |
| `api_backend` | Backend API | Python 3.10, FastAPI, Pandas, Statsmodels | Алибеков А. (Back-end) |
| `data_pipeline` | Конвейер подготовки данных | Python 3.10, Pandas, PyArrow, gdown | Бектеев Г.А. (Тимлид), Сырлыбаев Б.С. (Аналитик) |
| `data_store` | Хранилище демографических данных | Apache Parquet (PyArrow), файловая система (~6 ГБ) | Бектеев Г.А. (Тимлид), Сырлыбаев Б.С. (Аналитик) |
| `db_service` | Служебная БД | PostgreSQL 16 | Алибеков А. (Back-end), Сырлыбаев Б.С. (Аналитик) |

---

## 4. Компоненты контейнера `api_backend` (Component) — Level 3 (Алибеков А., Back-end)

| ID | Название | Слой архитектуры | Технология |
|---|---|---|---|
| `api_router` | API Router | Слой представления (Presentation) | FastAPI APIRouter, Pydantic v2 |
| `indicator_service` | Сервис демографических показателей | Слой бизнес-логики (Business Logic) | Python, Pandas, NumPy |
| `forecast_service` | Сервис прогнозирования | Слой бизнес-логики (Business Logic) | Python, Statsmodels, NumPy |
| `analytics_service` | Сервис пространственной аналитики и кластеризации | Слой бизнес-логики (Business Logic) | Python, scikit-learn, SciPy |
| `report_service` | Сервис генерации аналитических отчётов | Слой бизнес-логики (Business Logic) | Python, Jinja2, google-genai |
| `data_repo` | Репозиторий демографических данных | Слой доступа к данным (Data Access) | Python, PyArrow, Pandas |
| `db_repo` | Репозиторий служебной БД | Слой доступа к данным (Data Access) | Python, SQLAlchemy 2.0, asyncpg |

---

## 5. Компоненты контейнера `web_app` (Component) — Level 3 (Слисаренко Д., Front-end)

| ID | Название | Слой архитектуры | Технология |
|---|---|---|---|
| `app_router` | Маршрутизатор и макет (App Shell & Router) | Слой маршрутизации (Routing & Layout) | React Router v7, TypeScript |
| `dashboard_ui` | Модуль аналитических дашбордов | Слой представлений (Feature Views) | React 19, Apache ECharts |
| `forecast_ui` | Модуль конструктора прогнозов | Слой представлений (Feature Views) | React 19, React Hook Form, Zod |
| `map_ui` | Модуль интерактивной ГИС-карты | Слой представлений (Feature Views) | React 19, Deck.gl, MapLibre GL |
| `report_ui` | Модуль просмотра и экспорта отчётов | Слой представлений (Feature Views) | React 19, jsPDF, SheetJS |
| `heatmap_styler` | Движок расчёта цветовых шкал (Heatmap Styler) | Слой клиентской бизнес-логики (Domain Logic) | TypeScript (Pure Domain Logic) |
| `state_store` | Хранилище клиентского состояния | Слой состояния (State Management) | Zustand, TanStack Query v5 |
| `auth_client` | Клиентский модуль авторизации | Инфраструктурный слой (Infrastructure) | oidc-client-ts, TypeScript |
| `api_client` | HTTP-клиент API | Инфраструктурный слой (Infrastructure) | Axios, TypeScript |

---

## 6. Классы уровня кода (UML Class Diagram) — Level 4

### 6.1. Компонент `forecast_service` (`src/code/class_diagram.puml`, Алибеков А.)

| ID / Имя класса | Стереотип | Роль в паттерне Strategy |
|---|---|---|
| `IForecastStrategy` | `<<Interface>>` | Абстрактный интерфейс стратегии прогнозирования (`fit`, `predict`, `name`) |
| `ArimaForecaster` | Конкретная стратегия | Авторегрессионная модель проинтегрированного скользящего среднего ARIMA(p,d,q) |
| `HoltWintersForecaster` | Конкретная стратегия | Экспоненциальное сглаживание Хольта — Уинтерса с затухающим мультипликативным трендом |
| `CohortComponentForecaster` | Конкретная стратегия | Когортно-компонентный метод передвижки возрастов (матрица Лесли) |
| `ForecastEngine` | Контекст (Context) | Оркестратор стратегий: регистрация, переключение, запуск прогноза и ретроспективный бэктест |
| `TimeSeriesData` | `<<DataClass>>` | Входная структура временного ряда и половозрастной матрицы региона |
| `ForecastResult` | `<<DataClass>>` | Выходная структура прогноза (траектория, сценарий, горизонт, MAPE) |
| `ForecastPoint` | `<<DataClass>>` | Точка прогнозной траектории за один год (`year`, `point`, `lower_bound`, `upper_bound`) |

### 6.2. Компонент `heatmap_styler` (`src/code/frontend_classes.puml`, Слисаренко Д.)

| ID / Имя класса | Стереотип | Роль в паттерне Strategy |
|---|---|---|
| `ClassificationStrategy` | `<<Interface>>` | Интерфейс алгоритма разбиения значений регионов на интервалы (`computeBreaks`) |
| `QuantileStrategy` | Конкретная стратегия | Квантильное разбиение (равнонаполненные классы) |
| `EqualIntervalStrategy` | Конкретная стратегия | Разбиение диапазона на равные интервалы |
| `NaturalBreaksStrategy` | Конкретная стратегия | Алгоритм естественных границ Фишера — Дженкса (минимизация внутриклассовой дисперсии) |
| `HeatmapStylerContext` | Контекст (Context) | Формирование легенды (`buildLegend`) и раскраска полигонов регионов (`styleRegions`) |
| `RegionMetric` | `<<DataClass>>` | Входное значение показателя региона с флагом аномалии |
| `ColorScaleConfig` | `<<DataClass>>` | Настройки цветовой шкалы (число классов, имя палитры, инверсия) |
| `LegendBucket` | `<<DataClass>>` | Диапазон легенды карты с границами и HEX-цветом |
| `StyledFeature` | `<<DataClass>>` | Рассчитанный стиль геополигона субъекта РФ для отрисовки в Deck.gl / MapLibre |

---

## 7. Узлы и элементы развертывания (Deployment) — Level 2 Infrastructure (Сырлыбаев Б.С.)

| ID | Название | Тип | Описание |
|---|---|---|---|
| `gov_contour` | Ведомственная ИТ-инфраструктура | `Enterprise_Boundary` | Закрытый корпоративный контур на диаграмме ландшафта L0 |
| `client_pc` | Рабочая станция аналитика | `Deployment_Node` | Клиентский узел (Windows / macOS) с браузером SPA |
| `mobile_dev` | Смартфон пользователя | `Deployment_Node` | Мобильное устройство (Android / iOS) |
| `cloud` | Облачная инфраструктура (ЦОД) | `Deployment_Node` | Виртуальное частное облако Yandex Cloud VPC |
| `dmz_node` | Сервер веб-сервисов | `Deployment_Node` | Публичная VM в DMZ с обратным прокси |
| `nginx` | Reverse Proxy | `Container` | Веб-сервер Nginx (TLS-терминация, порт 443 -> 8000) |
| `app_node` | Сервер приложений | `Deployment_Node` | Виртуальная машина Docker-хоста |
| `docker_rt` | Docker Engine | `Deployment_Node` | Среда выполнения контейнеров Docker 24 |
| `etl_node` | Сервер пакетной обработки | `Deployment_Node` | Узел запуска регламентных ETL-заданий по расписанию Cron |
| `lake_node` | Сервер озера данных | `Deployment_Node` | Файловый сервер с NFS-томом для хранения Parquet-файлов |
| `db_primary` | Сервер БД (Мастер) | `Deployment_Node` | Основной узел кластера Managed PostgreSQL |
| `db_master` | Служебная БД (Мастер) | `ContainerDb` | Первичный экземпляр PostgreSQL 16 (запись и чтение, RW) |
| `db_standby` | Сервер БД (Реплика) | `Deployment_Node` | Резервный узел кластера Managed PostgreSQL |
| `db_replica` | Реплика БД (Standby) | `ContainerDb` | Горячая реплика PostgreSQL 16 (потоковая репликация WAL, чтение RO) |
