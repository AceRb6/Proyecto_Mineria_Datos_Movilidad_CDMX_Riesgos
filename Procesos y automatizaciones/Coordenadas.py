import pyautogui
import time
import os

print("--- DETECTOR DE COORDENADAS ---")
print("1. Haz scroll en tu página hasta que veas el botón.")
print("2. Pon el mouse encima del botón.")
print("3. Lee las coordenadas X, Y que salen aquí abajo.")
print("Presiona Ctrl + C para salir.")
print("-------------------------------")

try:
    while True:
        x, y = pyautogui.position()
        # Esto imprime y borra la línea para que sea fácil de leer
        print(f"POSICIÓN ACTUAL DEL MOUSE: X={x}   Y={y}    ", end="\r")
        time.sleep(0.1)
except KeyboardInterrupt:
    print("\nListo.")
