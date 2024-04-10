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


# Ejemplo de uso
numero = 48
numero_Q7_8 = "0001111100010000"
print(f"Número decimal {numero} en Q7.8: {numero_Q7_8}")

numero_decimal = Q7_8_a_decimal(numero_Q7_8)
print(f"Número Q7.8 {numero_Q7_8} en decimal: {numero_decimal}")
#0111110001000000000000