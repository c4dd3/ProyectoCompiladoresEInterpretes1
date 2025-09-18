package com.mycompany.proyectocompi1;

import java.io.FileReader;
//String archivo = "ProyectoCompi1/src/main/java/com/mycompany/proyectocompi1/test1.abs"; // En VSCode
//String archivo = "src/main/java/com/mycompany/proyectocompi1/test1.abs"; // En NetBeans

public class ProyectoCompi1 {
    public static void main(String[] args) {
        java.util.Scanner input = new java.util.Scanner(System.in);

        System.out.println("=== Menú de pruebas del Analizador Léxico ===");
        int i = 1;
        for (TestFile tf : TestFile.values()) {
            System.out.printf("%d) %s - %s%n", i, tf.getFileName(), tf.getDescription());
            i++;
        }
        System.out.print("Seleccione un número de prueba: ");
        int choice = input.nextInt();
        input.nextLine(); // limpiar buffer

        if (choice < 1 || choice > TestFile.values().length) {
            System.out.println("Opción inválida.");
            return;
        }

        TestFile selected = TestFile.values()[choice - 1];
        String archivo = "ProyectoCompi1/src/main/java/com/mycompany/proyectocompi1/test/" + selected.getFileName(); 


        System.out.println("\nEjecutando prueba: " + selected.getDescription());
        System.out.println("Archivo: " + archivo + "\n");

        try (FileReader reader = new FileReader(archivo)) {
            com.mycompany.proyectocompi1.Scanner scanner = new com.mycompany.proyectocompi1.Scanner(reader);
            while (scanner.yylex() != -1) {
                // Consumir tokens
            }
            TokenCollector.printResults();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}