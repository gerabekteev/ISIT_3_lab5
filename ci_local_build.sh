#!/usr/bin/env bash
# Локальная эмуляция CI-пайплайна .github/workflows/render-docs.yml
# Шаги 1-6 соответствуют jobs.validate-and-render; тексты шага линтера
# совпадают с текстами в YAML. Примечание: -o у PlantUML относителен
# каталогу КАЖДОГО исходника, поэтому используется абсолютный путь.
set -u
JAR="${PLANTUML_JAR:-C:/Fvus/ИСИТ_3_семестр/tools/plantuml.jar}"
IMG_DIR="$(pwd)/docs/images"

echo "[CI] Step 1: Checkout repository code -> OK (local working tree)"
echo "[CI] Step 2: Setup Java Environment -> $(java -version 2>&1 | head -1)"
echo "[CI] Step 3: Install Graphviz Engine -> $(dot -V 2>&1)"
echo "[CI] Step 4: Download PlantUML Jar Executable -> $(basename "$JAR")"

echo "[CI] Step 5: Lint: enforce methodologist rules (banned macros)"
if grep -rnE "Rel_(R|L|D|U)\(" src/ ; then
  echo "❌ CRITICAL FAILURE: banned macro Rel_R/Rel_L/Rel_D/Rel_U found."
  echo "Use standard 'Rel()' macro per methodologist guidelines."
  echo "----> Pipeline failed. Status: CRITICAL FAILURE ❌"
  exit 1
fi
echo "[INFO] No banned positioning macros detected."

echo "[CI] Step 6: Validate Syntax and Compile Diagrams to PNG"
FILES=$(find src -name "*.puml" | tr '\n' ' ')
echo "[INFO] Checking PlantUML syntax for: $FILES"
java -jar "$JAR" -charset UTF-8 -png -o "$IMG_DIR" $FILES || {
  echo "Error: PlantUML syntax check failed."
  echo "----> Pipeline failed. Status: CRITICAL FAILURE ❌"
  exit 1
}
echo "Job completed with exit code 0. Status: SUCCESS ✅"
