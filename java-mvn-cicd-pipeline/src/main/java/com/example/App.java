package com.example;

/**
 * Main application class for Java Maven CI/CD Pipeline demonstration.
 */
public class App {

    public static final String GREETING_MESSAGE = "Hello from Java Maven CI/CD Pipeline!";

    /**
     * Returns greeting message for unit testing.
     * @return greeting string
     */
    public String getMessage() {
        return GREETING_MESSAGE;
    }

    /**
     * Application entry point.
     * @param args Command-line arguments
     */
    public static void main(String[] args) {
        App app = new App();
        System.out.println(app.getMessage());
    }
}
