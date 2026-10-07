#!/bin/bash

# ================= CONFIGURATION =================
# Путь к директории с видеофайлами (без слэша на конце)
TARGET_DIR="/path/to/your/motion/videos"

# Количество дней (файлы СТАРЕЕ этого количества будут удалены)
DAYS_OLD=60

# Расширение файлов (например, mp4, avi). Оставьте "*" для всех типов.
FILE_EXT="mkv"

# Папка для хранения логов (без слэша на конце)
LOG_DIR="/home/maxi/logs"

# Имя лог-файла с текущей датой (ГГГГ-ММ-ДД)
CURRENT_DATE=$(date '+%Y-%m-%d')
LOG_FILE="${LOG_DIR}/motion_clean_${CURRENT_DATE}.log"
# =================================================

# Создаем папку для логов, если её ещё нет
mkdir -p "$LOG_DIR"

# Проверка, существует ли директория с видео
if [ ! -d "$TARGET_DIR" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] Директория $TARGET_DIR не найдена!" >> "$LOG_FILE"
    exit 1
fi

# Проверка наличия файлов для удаления
FILE_COUNT=$(find "$TARGET_DIR" -type f -name "*.$FILE_EXT" -mtime +"$DAYS_OLD" | wc -l)

# Если файлов нет, пишем одну строку в лог за этот день и выходим
if [ "$FILE_COUNT" -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Старых файлов для удаления не найдено." >> "$LOG_FILE"
    exit 0
fi

# Считаем общий объем освобождаемого места (например, 1.2G)
TOTAL_SIZE=$(find "$TARGET_DIR" -type f -name "*.$FILE_EXT" -mtime +"$DAYS_OLD" -exec du -ch {} + | grep total$ | cut -f1)

# Блок записи в лог
echo "==================================================" >> "$LOG_FILE"
echo "$(date '+%Y-%m-%d %H:%M:%S') [START] Найдено файлов: $FILE_COUNT (Объем: $TOTAL_SIZE)" >> "$LOG_FILE"
echo "--------------------------------------------------" >> "$LOG_FILE"

# Записываем список удаляемых файлов в лог и удаляем их
find "$TARGET_DIR" -type f -name "*.$FILE_EXT" -mtime +"$DAYS_OLD" -print -delete >> "$LOG_FILE"

echo "--------------------------------------------------" >> "$LOG_FILE"
echo "$(date '+%Y-%m-%d %H:%M:%S') [SUCCESS] Очистка завершена успешно." >> "$LOG_FILE"
echo "==================================================" >> "$LOG_FILE"

