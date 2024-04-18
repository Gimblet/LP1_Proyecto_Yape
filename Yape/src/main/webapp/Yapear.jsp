<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <title>Nuevo Yapeo</title>
        <style>
            .container {
                display: flex;
                flex-direction: column;
            }

            .form-container {
                align-self: center;
                border: 4px solid blue;
                padding: 45px 60px 45px 60px;
            }

            input:hover {
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h3>Yapeando desde : </h3>
            <div class="form-container">
                <form action="Servlet" method="post">
                    <h2>Yapear</h2>
                    <label>Numero</label><br><br>
                    <input type="text" name="txtNumero" required><br><br>
                    <label>Monto</label><br><br>
                    <input type="text" name="txtMonto" required><br><br>
                    <input type="submit" name="type" value="Verificar">
                    <h3>CONFIRMACION</h3>
                </form>
                <form action="Servlet" method="post">
                    <input type="submit" name="type" value="Confirmar">
                    <input type="submit" name="type" value="Cancelar">
                </form>
            </div>
        </div>
    </body>

    </html>