# java-mvn-cicd-pipeline

A sample Java 17 Maven project created for a college DevOps practical assignment demonstrating Continuous Integration and Continuous Deployment (CI/CD) using **GitHub**, **Maven**, and **Jenkins Pipeline as Code**.

---

## 📌 Project Overview

This project implements a lightweight Java console application configured with standard Maven build automation and JUnit unit testing. It is orchestrated via a declarative Jenkinsfile that automates code checkout, compilation, testing, packaging, and deployment stages.

---

## ⚙️ Prerequisites

To run and build this project locally, the following tools are required:

- **Java JDK**: Version 17 or higher (`java -version`, `javac -version`)
- **Apache Maven**: Version 3.8+ (`mvn -version`)
- **Git**: Version 2.x+ (`git --version`)
- **Jenkins**: Running server with Pipeline and JUnit plugins installed

---

## 📂 Project Structure

```text
java-mvn-cicd-pipeline/
├── .gitignore
├── Jenkinsfile
├── pom.xml
├── README.md
└── src/
    ├── main/
    │   └── java/
    │       └── com/
    │           └── example/
    │               └── App.java
    └── test/
        └── java/
            └── com/
                └── example/
                    └── AppTest.java
```

---

## 🚀 Build and Test Commands

Execute the following commands from the root directory of the project (`java-mvn-cicd-pipeline`):

### 1. Compile the Source Code
Compiles all Java source files under `src/main/java`:
```powershell
mvn clean compile
```

### 2. Run Unit Tests
Executes JUnit test cases and generates XML reports in `target/surefire-reports`:
```powershell
mvn test
```

### 3. Package the Application
Compiles, tests, and builds an executable JAR in the `target/` directory:
```powershell
mvn clean package
```

### 4. Run the Packaged Application
Run the generated JAR directly using the Java runtime:
```powershell
java -jar target/java-mvn-cicd-pipeline-1.0-SNAPSHOT.jar
```
**Expected Output:**
```text
Hello from Java Maven CI/CD Pipeline!
```

---

## 🔄 Jenkins CI/CD Pipeline Stages

The included `Jenkinsfile` automates the following pipeline workflow:

1. **Checkout**: Retrieves source code from GitHub repository.
2. **Build**: Compiles code using `mvn clean compile`.
3. **Unit Test**: Runs unit tests via `mvn test` and publishes JUnit XML test reports.
4. **Package**: Builds the JAR archive skipping redundant tests (`mvn package -DskipTests`).
5. **Deploy**: Copies the resulting JAR to the deployment destination (`/tmp/deployed-app.jar` on Linux or `C:\jenkins-deployments\deployed-app.jar` on Windows).

---

## 👨‍💻 Author
College DevOps Practical Assignment
