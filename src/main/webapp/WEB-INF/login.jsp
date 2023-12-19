<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>WaterBnB</title>
    <!-- for Bootstrap CSS -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/style.css" />
    <!-- For any Bootstrap that uses JS -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="container mt-5">
      <div class="d-flex justify-content-end">
        <a href="/" class="fs-3">Go back</a>
      </div>
      <div class="row">
        <div class="col-6 d-flex justify-content-center">
          <form:form
            action="/registration"
            method="post"
            modelAttribute="register"
            class="mt-5 w-100"
          >
            <fieldset class="border border-3 p-3">
              <legend class="float-none w-auto px-1">Register</legend>
              <div class="d-flex justify-content-between mt-3">
                <form:label path="firstName" class="fs-5 col-4"
                  >First Name:</form:label
                >
                <form:input path="firstName" class="col-8 form-control w-50" />
              </div>
              <form:errors path="firstName" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="lastName" class="fs-5">Last Name:</form:label>
                <form:input path="lastName" class="col-8 form-control w-50" />
              </div>
              <form:errors path="lastName" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="email" class="fs-5 col-4">Email:</form:label>
                <form:input
                  path="email"
                  type="email"
                  class="col-8 form-control w-50"
                />
              </div>
              <form:errors path="email" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="password" class="fs-5 col-4"
                  >Password:</form:label
                >
                <form:password
                  path="password"
                  class="col-8 form-control w-50"
                />
              </div>
              <form:errors path="password" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="passwordConfirmation" class="fs-5 col-4"
                  >Confirm Password:</form:label
                >
                <form:password
                  path="passwordConfirmation"
                  class="col-8 form-control w-50"
                />
              </div>
              <form:errors path="passwordConfirmation" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <label class="fs-5 col-4">Type of Account:</label>
                <form:select
                  class="form-select w-50 text-uppercase"
                  type="text"
                  path="rol"
                >
                  <c:forEach items="${roles}" var="rol">
                      <form:option class="text-uppercase" value="${rol}"></form:option>
                  </c:forEach>
                </form:select>
              </div>
              <div class="d-flex justify-content-end mt-3">
                <input type="submit" value="Register" class="btn btn-success" />
              </div>
            </fieldset>
          </form:form>
        </div>
        <div class="col-6 d-flex justify-content-center">
          <form:form
            action="/login"
            method="post"
            modelAttribute="login"
            class="mt-5 w-75"
          >
            <fieldset class="border border-3 p-3">
              <legend class="float-none w-auto px-1">Login</legend>
              <div class="d-flex justify-content-between mt-3">
                <form:label path="email" class="fs-5">Email:</form:label>
                <form:input
                  path="email"
                  type="email"
                  class="ms-3 form-control w-50"
                />
              </div>
              <form:errors path="email" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="password" class="fs-5">Password:</form:label>
                <form:password path="password" class="form-control w-50" />
              </div>
              <form:errors path="password" class="text-danger" />
              <p class="text-danger">${error}</p>
              <div class="d-flex justify-content-end mt-3">
                <input type="submit" value="Login" class="btn btn-success" />
              </div>
            </fieldset>
          </form:form>
        </div>
      </div>
    </div>
  </body>
</html>
