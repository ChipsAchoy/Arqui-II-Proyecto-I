import numpy as np
import matplotlib.pyplot as plt


def Q7_8_a_decimal(numero_binario):
    # Extraer el signo
    print(numero_binario)
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


def Q7_8_formating(array):
    formated_array = np.zeros_like(array)
    i = 0
    for value in array:
        Q7_8 = decimal_a_Q7_8(value)
        decimal = Q7_8_a_decimal(Q7_8)
        formated_array[i] = decimal
        i += 1

    return formated_array


def generate_time_array(duration, sampling_freq):
    t = np.linspace(0, duration, int(sampling_freq * duration), endpoint=False)
    return t


def generate_clean_signal(t, frequency):
    clean_signal = np.sin(2 * np.pi * frequency * t)
    return clean_signal


def generate_noisy_signal(clean_signal, noise_std_dev):
    noise = np.random.normal(0, noise_std_dev, len(clean_signal))
    noisy_signal = clean_signal + noise
    return noisy_signal


def decimal_a_Q7_8(numero):
    # Determinar el signo
    signo = '0'
    numero = float(numero)  # Convertir a flotante

    if numero < 0:
        signo = '1'
        numero = abs(numero)

    # Separar parte entera y decimal
    entero, decimal = str(numero).split('.')

    # Convertir parte entera a binario con 7 bits
    entero_binario = bin(int(entero))[2:].zfill(7)

    # Convertir parte decimal a binario con 8 bits
    decimal = float('0.' + decimal)
    decimal_binario = ''
    for _ in range(8):
        decimal *= 2
        if decimal >= 1:
            decimal_binario += '1'
            decimal -= 1
        else:
            decimal_binario += '0'

    # Combinar parte entera, decimal y signo
    numero_binario = signo + entero_binario + decimal_binario

    return numero_binario


def main():
    # Parámetros
    sampling_freq = 44100  # Frecuencia de muestreo (Hz)
    duration = 0.18  # Duración de la señal (segundos)
    frequency = 1000  # Frecuencia de la onda senoidal (Hz)
    noise_std_dev = 0.5  # Desviación estándar del ruido gaussiano

    # Generar arreglo de tiempo
    t = generate_time_array(duration, sampling_freq)

    # Generar señal limpia
    clean_signal = generate_clean_signal(t, frequency)

    # Generar señal ruidosa
    noisy_signal = generate_noisy_signal(clean_signal, noise_std_dev)

    # Convertir señal ruidosa a formato Q7.8
    noisy_signal_q7_8 = [decimal_a_Q7_8(value) for value in noisy_signal]

    # Coeficientes
    b16 = np.array([8.3436 * (10 ** (-3)), 1.3113 * (10 ** (-2)), 2.6482 * (10 ** (-2)), 4.6922 * (10 ** (-2)),
                    7.1219 * (10 ** (-2)), 9.5103 * (10 ** (-2)
                                                     ), 1.1414 * (10 ** (-1)), 1.2468 * (10 ** (-1)),
                    1.2468 * (10 ** (-1)), 1.1414 * (10 ** (-1)
                                                     ), 9.5103 * (10 ** (-2)), 7.1219 * (10 ** (-2)),
                    4.6922 * (10 ** (-2)), 2.6482 * (10 ** (-2)), 1.3113 * (10 ** (-2)), 8.3436 * (10 ** (-3))])

    b16_formated_array = Q7_8_formating(b16)

    # Array of 20 coefficients
    b20 = np.array([5.9451 * (10 ** (-3)), 8.3257 * (10 ** (-3)), 1.4865 * (10 ** (-2)), 2.5426 * (10 ** (-2)),
                    3.9222 * (10 ** (-2)), 5.4890 * (10 ** (-2)
                                                     ), 7.0679 * (10 ** (-2)), 8.4692 * (10 ** (-2)),
                    9.5175 * (10 ** (-2)), 1.0078 * (10 ** (-1)
                                                     ), 1.0078 * (10 ** (-1)), 9.5175 * (10 ** (-2)),
                    8.4692 * (10 ** (-2)), 7.0679 * (10 ** (-2)
                                                     ), 5.4890 * (10 ** (-2)), 3.9222 * (10 ** (-2)),
                    2.5426 * (10 ** (-2)), 1.4865 * (10 ** (-2)), 8.3257 * (10 ** (-3)), 5.9451 * (10 ** (-3))])

    b20_formated_array = Q7_8_formating(b20)

    # Array of 10 coefficients
    b10 = np.array([0.015327, 0.036911, 0.092319, 0.156521, 0.198922,
                    0.198922, 0.156521, 0.092319, 0.036911, 0.015327])

    b10_formated_array = Q7_8_formating(b10)

    # Seleccionar el arreglo de coeficientes deseado
    coefficients_array = b20_formated_array

    # Verificar la longitud de los coeficientes y rellenar si es necesario
    if len(coefficients_array) < 48:
        coefficients_array = np.pad(
            coefficients_array, (0, 48 - len(coefficients_array)), mode='constant')
    elif len(coefficients_array) > 48:
        coefficients_array = coefficients_array[:48]

    # Convertir coeficientes a Q7.8
    coefficients = [decimal_a_Q7_8(value) for value in coefficients_array]

    # Verificar la longitud de la señal ruidosa y truncar si es necesario
    if len(noisy_signal_q7_8) > 7950:
        noisy_signal_q7_8 = noisy_signal_q7_8[:7950]

    # Rellenar con ceros si la longitud de la señal es menor que 7952
    noisy_signal_q7_8 += ['0000000000000000'] * (7950 - len(noisy_signal_q7_8))

    # Combinar coeficientes y señal ruidosa
    data = coefficients + noisy_signal_q7_8

    # Calcular la cantidad de coeficientes y muestras en Q7.8
    num_coef_q7_8 = "{0:b}".format(len(coefficients_array))
    num_samples_q7_8 = "{0:b}".format(len(noisy_signal_q7_8))

    # Escribir archivo ram_ini.mif
    with open('ram_ini.mif', 'w') as file:
        file.write('WIDTH=16;\n')
        file.write('DEPTH=8000;\n')
        file.write('ADDRESS_RADIX=HEX;\n')
        file.write('DATA_RADIX=BIN;\n')
        file.write('CONTENT BEGIN\n')

        for i, value in enumerate(data):
            file.write(f'{i:04X} : {value};\n')

        # Escribir la cantidad de coeficientes en Q7.8
        file.write(f'{len(data):04X} : 0000000000{num_coef_q7_8};\n')

        # Escribir la cantidad de muestras en Q7.8
        file.write(f'{len(data) + 1:04X} : 000{num_samples_q7_8};\n')

        file.write('END;\n')


if __name__ == "__main__":
    main()
