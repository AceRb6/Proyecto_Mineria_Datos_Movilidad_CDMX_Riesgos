import pyautogui
import time
import keyboard  # Para detectar teclas
import sys       # Para cerrar el programa
import subprocess # Para abrir Opera

# --- CONFIGURACIÓN DE OPERA Y URL ---
# Apuntamos al ejecutable dentro de la carpeta que me diste
ruta_opera = r"C:\Users\artuk\AppData\Local\Programs\Opera GX\opera.exe"
url_objetivo = "https://smn.conagua.gob.mx/es/climatologia/temperaturas-y-lluvias/resumenes-mensuales-de-temperaturas-y-lluvias"

# --- TUS COORDENADAS (CONFIRMADAS) ---
coord_inicio = (100, 100) 
boton_desplegable_ano = (810, 638)
boton_desplegable_mes = (910, 638)
boton_descarga = (976, 682)

primer_elemento_ano_y = 665
primer_elemento_mes_y = 665
coordenada_x_lista_ano = 810
coordenada_x_lista_mes = 910

salto_pixeles = 24
cantidad_anos = 12
cantidad_meses = 12

# --- FUNCIÓN DE SEGURIDAD ---
def verificar_salida():
    if keyboard.is_pressed('esc'):
        print("\n!!! EJECUCIÓN INTERRUMPIDA !!!")
        sys.exit()

# --- PASO 1: ABRIR EL NAVEGADOR ---
print("Abriendo Opera GX con la URL...")
try:
    # Abre el navegador directamente en la página
    subprocess.Popen([ruta_opera, url_objetivo])
except FileNotFoundError:
    print("No se encontró 'launcher.exe'. Verifica si es 'opera.exe' o la ruta.")
    sys.exit()


# Espera de 10 segundos (detectando ESC) para que la página cargue bien
for _ in range(200):
    time.sleep(0.1)
    verificar_salida()

# TRUCO: Maximizar ventana para asegurar que las coordenadas no cambien
# (Simula presionar la tecla Windows + Flecha Arriba)
# pyautogui.hotkey('win', 'up')
time.sleep(1)

# --- PASO 2: INICIO DE TU RPA ---
pyautogui.FAILSAFE = True 

# Click inicial (por si hay que enfocar la página)
pyautogui.click(coord_inicio)
time.sleep(1)

# BUCLE DE AÑOS
for i in range(cantidad_anos):
    verificar_salida()
    
    # Abrir Año
    pyautogui.click(boton_desplegable_ano)
    time.sleep(0.2)
    
    # Calcular y Click Año
    y_ano_actual = primer_elemento_ano_y + (i * salto_pixeles)
    verificar_salida() 
    pyautogui.click(coordenada_x_lista_ano, y_ano_actual)
    time.sleep(0.2)
    
    print(f"--> Año {2013+i}") # Solo para que veas el progreso en consola

    # BUCLE DE MESES
    for j in range(cantidad_meses):
        verificar_salida() 
        
        # Abrir Mes
        pyautogui.click(boton_desplegable_mes)
        time.sleep(0.2)        
        
        # Calcular y Click Mes
        y_mes_actual = primer_elemento_mes_y + (j * salto_pixeles)        
        pyautogui.click(coordenada_x_lista_mes, y_mes_actual)
        time.sleep(0.2)
        
        verificar_salida()
        
        # Descargar
        pyautogui.click(boton_descarga)
        
        # Espera de la descarga (ajustada a tu gusto, 2.5 seg aprox total)
        time.sleep(0.5)
        for _ in range(20): 
            time.sleep(0.1)
            verificar_salida()
            
        # Confirmar descarga (Enter)
        pyautogui.hotkey('enter')
        time.sleep(0.5)

