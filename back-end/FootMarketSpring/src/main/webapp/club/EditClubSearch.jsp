<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pretraga kluba za izmenu</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #eef1f7;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 450px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #1a73e8;
        }
        label {
            margin-top: 10px;
            font-weight: bold;
        }
        input {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
            width: 100%;
        }
        .error {
            color: red;
            font-size: 0.9em;
            margin-top: 4px;
        }
        button {
            margin-top: 20px;
            padding: 10px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #155ec4;
        }
        p {
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Pretraga kluba za izmenu</h2>

    <form:form modelAttribute="clubSearchDTO" action="${pageContext.request.contextPath}/clubController/findForEdit" method="post">
        <label for="name">Ime kluba:</label>
        <form:input path="name" id="name" />
        <form:errors path="name" cssClass="error" />

        <button type="submit">Pronađi</button>
    </form:form>

    <p style="color:red;">${error}</p>
    <%@ include file="/common/BackToHome.jspf" %>
</div>

</body>
</html>
