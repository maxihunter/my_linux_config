import RPi.GPIO as GPIO
import time
import sys

PIN_MAP = {
    "1": 17,
    "2": 18
}

def usage():
    print("Использование: python3 script.py <1|2> <on|off|switch>")
    print("  1 -> GPIO 17")
    print("  2 -> GPIO 18")
    print("  on     -> включить")
    print("  off    -> выключить")
    print("  switch -> HIGH 1 сек, LOW 1 сек, HIGH")

if len(sys.argv) != 3:
    usage()
    sys.exit(1)

pin_arg = sys.argv[1]
action = sys.argv[2].lower()

if pin_arg not in PIN_MAP:
    print("Ошибка: первый параметр должен быть 1 или 2")
    usage()
    sys.exit(1)

if action not in ("on", "off", "switch"):
    print("Ошибка: второй параметр должен быть on, off или switch")
    usage()
    sys.exit(1)

pin = PIN_MAP[pin_arg]

GPIO.setmode(GPIO.BCM)
GPIO.setup(pin, GPIO.OUT)

if action == "on":
    GPIO.output(pin, GPIO.HIGH)

elif action == "off":
    GPIO.output(pin, GPIO.LOW)

elif action == "switch":
    try:
        GPIO.output(pin, GPIO.HIGH)
        time.sleep(1)
        GPIO.output(pin, GPIO.LOW)
        time.sleep(1)
        GPIO.output(pin, GPIO.HIGH)
    finally:
        GPIO.cleanup(pin)
