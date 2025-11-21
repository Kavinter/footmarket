# FootMarket

FootMarket is a full-stack web application for browsing, searching, and managing football players, clubs, and transfers. The project is built using Spring Boot on the backend and Angular on the frontend, with MySQL as the database system.

## 1. Technologies

### Backend
- Java 17+
- Spring Boot
- Spring Web
- Spring Security
- Spring Data JPA / Hibernate
- MySQL
- Maven

### Frontend
- Angular
- TypeScript
- HTML / CSS

### Other
- Git
- REST API
- SQL dump located in the `/database` directory

## 2. Project Structure

```
FootMarket/
│
├── back-end/                 Spring Boot application
│   ├── src/main/java/...     Java source code and controllers
│   ├── src/main/resources/   Configuration (application-example.properties)
│   └── pom.xml               Maven configuration
│
├── front-end/                Angular application
│   ├── src/                  Angular source code
│   ├── package.json
│   ├── angular.json
│   └── environments/         (environment.ts is ignored)
│
├── database/                 SQL database dump
│   └── footmarket_dump.sql
│
└── README.md
```

## 3. Running the Backend

1. Import the project into Eclipse/IntelliJ as a Maven project.
2. Create the following file:

```
back-end/src/main/resources/application.properties
```

3. Add your database configuration:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/footmarket
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
```

4. Run the backend:

From IDE using the main class annotated with `@SpringBootApplication`,  
or from terminal:

```
mvn spring-boot:run
```

The backend runs at:

```
http://localhost:8080
```

## 4. Running the Frontend

1. Navigate to the frontend directory:

```
cd front-end
```

2. Install required packages:

```
npm install
```

3. Create the following file:

```
front-end/src/environments/environment.ts
```

4. Add this configuration:

```ts
export const environment = {
  production: false,
  apiBaseUrl: 'http://localhost:8080'
};
```

5. Run the Angular application:

```
ng serve
```

The frontend runs at:

```
http://localhost:4200
```

## 5. Database Setup

The `/database` directory contains the SQL dump:

```
footmarket_dump.sql
```

To import the database:

- phpMyAdmin → Import
- MySQL Workbench → Server → Data Import

Once imported, the backend can connect and operate normally.

## 6. API Overview

The backend exposes REST API endpoints for:

### Clubs
- GET `/api/clubs`
- GET `/api/clubs/{id}`
- POST `/api/clubs`
- DELETE `/api/clubs/{id}`

### Players
- GET `/api/players`
- GET `/api/players/{id}`
- POST `/api/players`
- DELETE `/api/players/{id}`

### Transfers
- GET `/api/transfers`
- POST `/api/transfers`

(Endpoints may vary depending on your implementation.)

## 7. Security

The backend uses:
- JWT authentication
- Role-based authorization

Example login:

```
POST /api/auth/login
```

Clients must include the JWT in requests:

```
Authorization: Bearer <token>
```

## 8. Notes

- `application.properties` and `environment.ts` are excluded from the repository for security reasons.
- Template versions of these files are provided:
  - `application-example.properties`
  - `environment.example.ts`

These templates are intended for developers to create their own local configurations.

## 9. Author

FootMarket project — academic full-stack application development work.
