package com.example;

import org.junit.Test;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

/**
 * Unit test for App.
 */
public class AppTest {

    @Test
    public void testAppInitialization() {
        App app = new App();
        assertNotNull("App instance should not be null", app);
    }

    @Test
    public void testGreetingMessage() {
        App app = new App();
        String expectedMessage = "Hello from Java Maven CI/CD Pipeline!";
        assertEquals("Greeting message should match expected output", expectedMessage, app.getMessage());
    }
}
