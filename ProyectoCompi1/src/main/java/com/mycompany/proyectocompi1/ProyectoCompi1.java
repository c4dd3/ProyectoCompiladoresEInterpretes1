package com.mycompany.proyectocompi1;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class ProyectoCompi1 {
    public static void main(String[] args) {
        // Ruta del archivo de prueba (puede pasarse por args o dejarse fija)
        String archivo = "ProyectoCompi1/src/main/java/com/mycompany/proyectocompi1/test1.abs"; // En VSCode
        //String archivo = "src/main/java/com/mycompany/proyectocompi1/test1.abs"; // En NetBeans
        try (FileReader reader = new FileReader(archivo)) {
            // Crear scanner con el archivo
            Scanner scanner = new Scanner(reader);

            // Consumir todo el archivo
            while (scanner.yylex() != -1) {
                // yylex() devuelve -1 al llegar al EOF
                // El TokenCollector ya se encarga de registrar tokens y errores
            }

            // Al terminar, imprimir resultados
            TokenCollector.printResults();

        } catch (FileNotFoundException e) {
            System.err.println("No se encontró el archivo: " + archivo);
        } catch (IOException e) {
            System.err.println("Error de entrada/salida: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
