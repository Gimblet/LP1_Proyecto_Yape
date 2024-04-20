package data;

public class ClaseUtilitaria {
	private String respuesta, nombreRecipiente, nombreRemitente, fecha, hora, estado;
	private int idYape, numeroRecipiente, numeroRemitente;
	private double montoRecipiente;

	public String getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(String respuesta) {
		this.respuesta = respuesta;
	}

	public int getNumeroRecipiente() {
		return numeroRecipiente;
	}

	public void setNumeroRecipiente(int numeroRecipiente) {
		this.numeroRecipiente = numeroRecipiente;
	}

	public String getNombreRecipiente() {
		return nombreRecipiente;
	}

	public void setNombreRecipiente(String nombreRecipiente) {
		this.nombreRecipiente = nombreRecipiente;
	}

	public double getMontoRecipiente() {
		return montoRecipiente;
	}

	public void setMontoRecipiente(double montoRecipiente) {
		this.montoRecipiente = montoRecipiente;
	}

	public String getNombreRemitente() {
		return nombreRemitente;
	}

	public void setNombreRemitente(String nombreRemitente) {
		this.nombreRemitente = nombreRemitente;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getIdYape() {
		return idYape;
	}

	public void setIdYape(int idYape) {
		this.idYape = idYape;
	}

	public int getNumeroRemitente() {
		return numeroRemitente;
	}

	public void setNumeroRemitente(int numeroRemitente) {
		this.numeroRemitente = numeroRemitente;
	}
}
