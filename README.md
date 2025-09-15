


## Funcionamiento del controlador `ClientesController`

Este controlador expone el endpoint `GET /clientes?tipo=C&numero=123456` para consultar información de clientes por tipo y número de documento.

### Detalles:

- **Parámetros requeridos:**
	- `tipo`: Tipo de documento (`C` para cédula, `P` para pasaporte).
	- `numero`: Número de documento.
- **Validaciones:**
	- Ambos parámetros son obligatorios.
	- El tipo debe ser `C` o `P`.
- **Datos:**
	- Los datos de clientes están "quemados" en el controlador para pruebas.
- **Respuestas:**
	- Si el cliente existe, retorna sus datos en formato JSON y código 200.
	- Si no existe, retorna error y código 404.
	- Si faltan parámetros o el tipo es inválido, retorna error y código 400.
	- Si ocurre un error interno, retorna error y código 500.


Probar el servicio

Levanta el servidor:

rails s

Ejemplos:

✅ Caso exitoso (200):

curl "http://localhost:3000/clientes?tipo=C&numero=123456"

Respuesta:

{
  "primer_nombre": "Juan",
  "segundo_nombre": "Sebastián",
  "primer_apellido": "Vernaza",
  "segundo_apellido": "Lopez",
  "telefono": "3001234567",
  "direccion": "Calle 123 #45-67",
  "ciudad": "Cali"
}

❌ Parámetros faltantes (400):

curl "http://localhost:3000/clientes?tipo=C"

❌ Tipo inválido (400):

curl "http://localhost:3000/clientes?tipo=X&numero=123"

❌ Cliente no encontrado (404):

curl "http://localhost:3000/clientes?tipo=C&numero=999999"

❌ Error interno (500):
Para simularlo puedes forzar un raise "Error de prueba" dentro del controlador.
