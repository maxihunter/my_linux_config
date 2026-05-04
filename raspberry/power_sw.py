import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)  # Use BCM GPIO numbers
GPIO.setup(17, GPIO.OUT)

try:
    GPIO.output(17, GPIO.HIGH) # Turn on
    time.sleep(1)
    GPIO.output(17, GPIO.LOW)  # Turn off
    time.sleep(1)
    GPIO.output(17, GPIO.HIGH) # Turn on
finally:
    GPIO.cleanup() # Reset pins on exit


