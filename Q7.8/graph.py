import matplotlib.pyplot as plt

# Función para convertir una cadena binaria a un valor decimal en formato Q7.8
def Q7_8_a_decimal(numero_binario):
    # Extraer el signo
    numero_binario = numero_binario.replace(" ", "")
    signo = -1 if numero_binario[0] == '1' else 1

    # Separar parte entera y decimal
    if '.' in numero_binario:
        entero_binario, decimal_binario = numero_binario[1:].split('.')
    else:
        entero_binario = numero_binario[1:8]
        decimal_binario = numero_binario[8:]

    # Convertir parte entera a decimal
    entero_decimal = int(entero_binario, 2)

    # Convertir parte decimal a decimal
    decimal_decimal = 0
    for i, bit in enumerate(decimal_binario, 1):
        decimal_decimal += int(bit) * (2 ** -i)

    # Calcular el número decimal final
    numero_decimal = signo * (entero_decimal + decimal_decimal)

    return numero_decimal


# Leer el archivo .mif
with open('ram_ini.mif', 'r') as file:
    lines = file.readlines()

# Extraer los datos binarios del archivo
data = []
for line in lines:
    if line.strip().startswith('0') | line.strip().startswith('1'):
        data.append(line.strip().split(':')[1].strip(';'))

# Convertir los datos binarios a valores decimales en formato Q7.8
dec_data = [Q7_8_a_decimal(bin_str) for bin_str in data]

# Crear una lista de índices para el eje x
indices = list(range(len(dec_data)))

# Crear la gráfica
plt.figure(figsize=(12, 6))
plt.plot(indices[48:(len(indices)//30)], dec_data[48:(len(dec_data)//30)], marker='o')
plt.xlabel('Índice')
plt.ylabel('Valor')
plt.title('Distribución de Puntos (Formato Q7.8)')

# Mostrar la gráfica
plt.show()