class ClientesController < ApplicationController
  # Servicio: GET /clientes?tipo=C&numero=123456
  def show
    tipo = params[:tipo]
    numero = params[:numero]

    # Validaciones de parámetros
    if tipo.blank? || numero.blank?
      render json: { error: "Faltan parámetros obligatorios" }, status: :bad_request # 400
      return
    end

    unless [ "C", "P" ].include?(tipo)
      render json: { error: "Tipo de documento no válido. Use C o P" }, status: :bad_request # 400
      return
    end

    # Datos "quemados"
    clientes = {
      "C-123456" => {
        primer_nombre: "Juan",
        segundo_nombre: "Sebastián",
        primer_apellido: "Vernaza",
        segundo_apellido: "Lopez",
        telefono: "3001234567",
        direccion: "Calle 123 #45-67",
        ciudad: "Cali"
      },
      "P-ABC123" => {
        primer_nombre: "Usuario",
        segundo_nombre: "Probando",
        primer_apellido: "Prueba",
        segundo_apellido: "Dos",
        telefono: "3110000000",
        direccion: "Calle 120 #20-30",
        ciudad: "Bogotá"
      }
    }

    # Buscar cliente
    cliente = clientes["#{tipo}-#{numero}"]

    if cliente
      render json: cliente, status: :ok # 200
    else
      render json: { error: "Cliente no encontrado" }, status: :not_found # 404
    end
  rescue => e
    render json: { error: "Error interno del servidor: #{e.message}" }, status: :internal_server_error # 500
  end
end
